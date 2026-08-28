#!/usr/bin/env bash
# Flag \cref/\Cref targets that resolve to a chapter or section number.
#
# Environments declared with \newtheorem*{...} (example, remark, exercise,
# claim*, importantremark, notation, ...) are unnumbered, so a \label inside
# one attaches to whatever counter was stepped last -- usually the chapter or
# section. \cref then prints "Chapter 3" where "Example ..." was meant, and
# LaTeX reports no error. House style (gemini.md) is to reference such
# environments with \cpageref instead.
#
# Run after a successful pdflatex pass, from the repository root:
#     bash tools/check-crefs.sh
set -u

AUX=en-linalg-2.aux
[ -f "$AUX" ] || { echo "$AUX not found -- run pdflatex first."; exit 1; }
[ -s "$AUX" ] || { echo "$AUX is empty -- run pdflatex first."; exit 1; }

# Collect every \cref/\Cref target, then hand the .aux and the target list to a
# single awk run. The .aux is ~370 kB and the document has ~590 distinct
# targets; indexing the file once and looking each label up in a hash replaces
# the one-grep-per-label loop this used to do, which re-scanned the whole .aux
# once per label and took over two minutes. It now runs in well under a second.
grep -oh '\\[cC]ref{[^}]*}' content/*.tex \
  | sed 's/\\[cC]ref{//; s/}//' \
  | tr ',' '\n' \
  | sed 's/^[[:space:]]*//; s/[[:space:]]*$//' \
  | grep -v '^$' \
  | sort -u \
  | awk '
  # Content of the balanced {...} group starting at character i of s, or ""
  # if the braces do not close. The number field is not always a plain "1.1":
  # an \item relabelled with \textbf{(c)} stores its own braces in there.
  function balanced(s, i,   depth, j, c) {
    if (substr(s, i, 1) != "{") return ""
    depth = 0
    for (j = i; j <= length(s); j++) {
      c = substr(s, j, 1)
      if (c == "{") depth++
      else if (c == "}") {
        if (--depth == 0) return substr(s, i + 1, j - i - 1)
      }
    }
    return ""
  }

  # ---- first file: index the .aux -----------------------------------------
  NR == FNR {
    if (substr($0, 1, 10) != "\\newlabel{") next
    rest = substr($0, 11)
    p = index(rest, "}")
    if (p == 0) next
    lbl = substr(rest, 1, p - 1)
    if (lbl in num) next            # first \newlabel wins, as grep -m1 did

    # \newlabel{LABEL}{{NUM}{PAGE}{CAPTION}{ANCHOR}{}} -- NUM is the first
    # inner group: skip the outer brace, then read one balanced group.
    tail = substr(rest, p + 1)
    if (substr(tail, 1, 2) != "{{") next
    num[lbl] = balanced(tail, 2)

    # The caption field may itself contain braces (\cref, \textit, ...), so do
    # not try to count brace groups: the hyperref anchor is simply the last
    # group before the trailing "{}}".
    line = $0
    sub(/[[:space:]]+$/, "", line)
    sub(/\{\}\}$/, "", line)
    if (match(line, /\{[^{}]*\}$/))
      anchor[lbl] = substr(line, RSTART + 1, RLENGTH - 2)
    else
      anchor[lbl] = line
    next
  }

  # ---- second file: one \cref target per line ------------------------------
  {
    label = $0
    if (!(label in num)) {
      printf "UNRESOLVED  %s\n", label
      bad = 1
      next
    }
    n = num[label]
    a = anchor[label]

    # (1) The anchor is a heading: the label sits in an unnumbered environment
    #     and picked up the enclosing chapter/section. Labels that deliberately
    #     mark a heading are spelled ch:*/sec:*/subsec:* and are legitimate.
    #     Subsections are unnumbered in this document, so a \cref to one prints
    #     the enclosing *section* number: only chapter.*/section.* anchors may
    #     be whitelisted, and only for a label that says so in its prefix.
    if (a ~ /^chapter\./) {
      if (label !~ /^ch:/) {
        printf "BAD  %-40s prints \"%s\"  (anchor %s)\n", label, n, a
        bad = 1
      }
      next
    }
    if (a ~ /^section\./) {
      if (label !~ /^sec:/) {
        printf "BAD  %-40s prints \"%s\"  (anchor %s)\n", label, n, a
        bad = 1
      }
      next
    }
    if (a ~ /^subsection\./) {
      printf "BAD  %-40s prints \"%s\"  (anchor %s, subsections are unnumbered -- use \\cpageref)\n", label, n, a
      bad = 1
      next
    }

    # (2) A bare integer is a chapter number. Every numbered environment in
    #     this document prints Chapter.Number or Chapter.Section.Number, so a
    #     label that prints just "4" drifted onto the chapter counter even when
    #     the hyperref anchor happens to point somewhere else (e.g.
    #     figure.caption.N).
    if (n ~ /^[0-9]+$/) {
      printf "BAD  %-40s prints \"%s\"  (anchor %s)\n", label, n, a
      bad = 1
      next
    }

    # (2b) "12.a" is a *section* number. A numbered environment always prints
    #      Chapter.Number or Chapter.Letter.Number, so a trailing letter means
    #      the label drifted onto the section counter -- even when the hyperref
    #      anchor points at the environment that happened to precede it.
    if (label !~ /^(ch|sec|subsec):/ && n ~ /^[0-9].*\.[a-z]$/) {
      printf "BAD  %-40s prints \"%s\"  (anchor %s, section number)\n", label, n, a
      bad = 1
      next
    }

    # (3) Only fig:* labels should land on a figure counter.
    if (a ~ /^figure\./ && label !~ /^fig:/) {
      printf "BAD  %-40s prints \"%s\"  (anchor %s, not a fig: label)\n", label, n, a
      bad = 1
    }
  }

  END {
    if (!bad) print "OK: every \\cref target resolves to a numbered environment."
    exit (bad ? 1 : 0)
  }
  ' "$AUX" -
