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

tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT

grep -oh '\\[cC]ref{[^}]*}' content/*.tex \
  | sed 's/\\[cC]ref{//; s/}//' \
  | tr ',' '\n' \
  | sed 's/^[[:space:]]*//; s/[[:space:]]*$//' \
  | grep -v '^$' \
  | sort -u > "$tmp"

bad=0
while read -r label; do
  # One \newlabel per line. The caption field may itself contain braces
  # (\cref, \textit, ...), so do not try to count brace groups: the hyperref
  # anchor is simply the last group before the trailing "{}}".
  line=$(grep -m1 -F "\\newlabel{$label}{" "$AUX")
  if [ -z "$line" ]; then
    printf 'UNRESOLVED  %s\n' "$label"
    bad=1
    continue
  fi
  anchor=$(printf '%s' "$line" | sed 's/{}}[[:space:]]*$//' | sed 's/.*{\([^{}]*\)}$/\1/')
  num=$(printf '%s' "$line" | sed 's/.*newlabel{[^}]*}{{//; s/}{.*//')

  # (1) The anchor is a heading: the label sits in an unnumbered environment
  #     and picked up the enclosing chapter/section. Labels that deliberately
  #     mark a heading are spelled ch:*/sec:*/subsec:* and are legitimate.
  case "$anchor" in
    chapter.*|section.*|subsection.*)
      case "$label" in
        ch:*|sec:*|subsec:*) ;;
        *)
          printf 'BAD  %-40s prints "%s"  (anchor %s)\n' "$label" "$num" "$anchor"
          bad=1
          continue
          ;;
      esac
      ;;
  esac

  # (2) A bare integer is a chapter number. Every numbered environment in this
  #     document prints Chapter.Number or Chapter.Section.Number, so a label
  #     that prints just "4" drifted onto the chapter counter even when the
  #     hyperref anchor happens to point somewhere else (e.g. figure.caption.N).
  case "$num" in
    ''|*[!0-9]*) ;;
    *)
      printf 'BAD  %-40s prints "%s"  (anchor %s)\n' "$label" "$num" "$anchor"
      bad=1
      continue
      ;;
  esac

  # (2b) "12.a" is a *section* number. A numbered environment always prints
  #      Chapter.Number or Chapter.Letter.Number, so a trailing letter means the
  #      label drifted onto the section counter -- even when the hyperref anchor
  #      points at the environment that happened to precede it.
  case "$label" in
    ch:*|sec:*|subsec:*) ;;
    *)
      case "$num" in
        [0-9]*.[a-z])
          printf 'BAD  %-40s prints "%s"  (anchor %s, section number)\n' \
            "$label" "$num" "$anchor"
          bad=1
          continue
          ;;
      esac
      ;;
  esac

  # (3) Only fig:* labels should land on a figure counter.
  case "$anchor" in
    figure.*)
      case "$label" in
        fig:*) ;;
        *)
          printf 'BAD  %-40s prints "%s"  (anchor %s, not a fig: label)\n' \
            "$label" "$num" "$anchor"
          bad=1
          ;;
      esac
      ;;
  esac
done < "$tmp"

if [ "$bad" -eq 0 ]; then
  echo "OK: every \\cref target resolves to a numbered environment."
fi
exit $bad
