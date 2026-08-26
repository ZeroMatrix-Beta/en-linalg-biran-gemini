# Rigour audit (reading the LaTeX alone)

Working notes for the second audit pass over this book. Branch
`review/verify-against-source`. Last updated after ch. 18 was pushed
(`05a9289`). Chs. 16, 17a--17e and 18 are done.

This is a different pass from the source-verification audit. That one compared
`content/*.tex` against Prof. Biran's scans in `source/` and restored what the
transcription had dropped. This one reads **only the LaTeX**, and looks for
places where the mathematics is not rigorous: missing definitions, statements
that are used but never stated, steps asserted without a reason, and notation
that contradicts the book's own conventions.

## The rules for this pass

1. **Statements already sitting in running prose get an unnumbered
   environment**, `definition*` or `proposition*`, never a numbered one. This
   is the whole point: Prof. Biran's printed numbers must not shift, and
   nothing downstream may move.
2. **Cite unnumbered environments with `\cpageref`.** A `\label` inside an
   unnumbered environment attaches to whatever counter was stepped last, so
   `\cref` silently prints the enclosing chapter number. `tools/check-crefs.sh`
   exists to catch exactly that.
3. **Unnumbered for Prof. Biran's statements, `ai` for your own.** The two
   routes both leave his numbering alone, so the choice between them is not a
   typesetting decision, it is a claim about **provenance**, and a reader uses
   it to tell the lecture material from the machine's additions:
   - the statement stands *somewhere* in the notes with no environment at all,
     in bare running prose $\Rightarrow$ unnumbered `definition*` /
     `proposition*` / `lemma*`, cited with `\cpageref`;
   - the statement is in the notes but already **housed** in a `remark`, a
     `notation`, a `summary`, an `example` $\Rightarrow$ **leave it in that
     environment** and label it where it stands. Those all carry numbers, each
     on a counter of its own reset per chapter, with `\crefname` registered, so
     the label takes the ordinary `\cref` and prints \qt{Remark 24.2}. Never
     promote a Remark into a Proposition: it already has a home, and rehousing
     it rewrites the author's presentation to buy a citation that is free;
   - the statement is *nowhere* in the notes, whether it closes a gap they
     leave implicit or lifts a step out of one of his proofs to make it
     citable $\Rightarrow$ `aidefinition` / `ailemma` / `aiproposition`, which
     are numbered on their own counter, carry the robot marker, and take the
     ordinary `\cref`.

   The test is *where the statement appears, not how hard it is*: a result he
   states without proving is still his; a result he never states, even one
   assembled entirely out of three of his own, is yours. Through ch. 17d no
   `ai` case arose, and ch. 17e produced the first one. This rule now also
   lives in `gemini.md`, so it survives this file.
4. **Expand with parenthetical remarks.** `(i.e., ...)`, `(recall: ...)`,
   `(see ...)` add the reason for a step without rewording the sentence around
   it, which keeps the diff honest and the author's voice intact. A snappy
   second proof is welcome where one exists.
5. **Change prose only when the mathematics in it is wrong.** A word that
   carries mathematical content counts: replacing \qt{conversely} by \qt{in the
   other order} where nothing is converted is a correction, not a restyling.
   Rules 4 and 5 now also live in `gemini.md`, under \qt{Auditing an Existing
   Chapter}, so they survive this file the way rule 3 does. That entry also
   scopes the \qt{freedom to expand the prose} of `gemini.md` §2 to the
   transcription pass, which is where it belongs; read against an
   already-written chapter it says the opposite of these two rules.
6. **Provenance tags** as everywhere else in the book: `% Creator: Opus 5`
   opens a block written in this pass, and `% Extractor: Gemini 3.1 Pro` closes
   it so the code that follows is attributed again. **No reasoning-effort level
   in the tag.** Earlier sessions wrote `Opus 5 (High)` and `Opus 5 (Max)`; all
   156 of those were swept back to plain `Opus 5`, since the effort setting
   varies per session, records nothing about who wrote the prose, and does not
   appear on the `Gemini 3.1 Pro` tags either.
7. **One chapter per commit**, build before committing, then push.

## Status

| Chapter | File | State |
|---|---|---|
| 16 | `content/16-linear-maps-and-bases.tex` | done, pushed (`185f340`) |
| 17a | `content/17a-matrices_a_matrix_multiplication.tex` | done, pushed (`932b403`, `15b15cd`) |
| 17b | `content/17b-matrices_b_change_of_basis.tex` | done, pushed (`0c1499c`) |
| 17c | `content/17c-matrices_c_column_rank_and_row_rank.tex` | done, pushed (`b9078db`) |
| 17d | `content/17d-matrices_d_more_on_matrices_and_lineq.tex` | done, pushed (`eeb79e5`) |
| 17e | `content/17e-matrices_e_elemntary_row_operations_revisited.tex` | done, pushed (`0e28b77`) |
| 18 | `content/18-vs-out-of-old-ones.tex` | done, pushed (`05a9289`) |
| 10a | `content/10a-bases-part-a.tex` | done, pushed (`dce0ec0`) |
| 11 | `content/11-bases-part-b.tex` | done, pushed (`76f618f`) |
| 12 | `content/12-dimension.tex` | done, pushed (`0f0586d`) |
| 13 | `content/13-row-and-col-space.tex` | done, pushed (`1c2ce5c`) |
| 14 | `content/14-sums-of-vector-spaces.tex` | done, pushed (`3a264d5`) |
| 15 | `content/15a-linear-maps.tex` | done, pushed (`9121804`); this one file holds both 15.a and 15.b |
| 19 | `content/19-misc.tex` | done, pushed (`e8a9875`) |
| 20 | `content/20-determinants.tex` | done, pushed (`d4bc841`) |
| 21 | `content/21-eigenvalues-eigenvectors.tex` | done, pushed (`394f9d4`) |
| 22a | `content/22a-euclidean-hermetian-spaces-a.tex` | done, pushed (`9198c79`) |
| 22b | `content/22b-euclidean-hermetian-spaces-b.tex` | done, pushed (`2477582`) |
| 23a | `content/23a-dual-spaces-inner-products-a.tex` | done, pushed (`71b01c9`) |
| 24 | `content/24-spectral-thoerem.tex` | done, pushed (`8b3fcb9`) |
| 25 | `content/25-isometries.tex` | done, pushed (`6311bc5`) |
| 26 | `content/26-singular-value-decomposition.tex` | done, pushed (`d1b8d9b`) |
| 27 | `content/27-bilinear-and-quadratic-forms.tex` | done, pushed (`b90fd0c`) |
| 28a | `content/28-jordan-a.tex` | done, pushed (`8666eb5`) |
| 28b | `content/28b-jordan-b.tex` | done, pushed (`307ecb5`) |
| 1 | `content/01-fibonacci.tex` | done, pushed (`d029914`) |
| 2 | `content/02-logic.tex` | done, pushed (`13f6122`) |
| 3 | `content/03-set-theory.tex` | done, pushed (`5d4ee79`) |
| 4 | `content/04-maps.tex` | done, pushed (`cfe1639`) |
| 5 | `content/05-fields.tex` | done, pushed (`c09a79e`) |
| 6 | `content/06-systems-of-linear-equations.tex` | done, pushed (`394b3fd`) |
| 7 | `content/07-vector-spaces.tex` | done, pushed (`239739f`) |
| 8 | `content/08-span.tex` | done |
| **9** | `content/09-linear-independence.tex` | **the last one; this is where to resume** |

**Chs. 10a to 28b are now complete.** Only the nine foundational chapters remain.

Ch. 17, the matrices chapter, is finished: 17a to 17e are all done.

Each chapter's own `ainote` at the end of its file records what the pass did to
it, in the book itself. This file is the view across chapters.

## What the pass turned up

### Ch. 16, four central facts with no environment at all

The chapter states four of its main results in running prose:

- the coordinate map `\Phi_{\mathcal{B}}`, which Prop. 16.2 is *named after* and
  which ch. 18 uses throughout, was never named;
- the representation matrix itself, the central object of the book;
- the column description of `[T]_{\mathcal{C}}^{\mathcal{B}}`, which chs. 17b,
  18, 22a and 25 all cite as \qt{the definition of the representation matrix}
  although it is a derived fact;
- the composition rule, the punchline of the chapter.

All four now have unnumbered environments, so 16.1 to 16.4 are untouched. The
column description keeps the existing derivation as its proof.

### Ch. 17a, the inverted indices

**The one real error of the pass so far.** The entire proof of Prop. 17.a.2
wrote `[T_A]_{\mathcal{E}_n}^{\mathcal{E}_m}` for the map `T_A: K^n -> K^m`,
putting the basis of the *target* on top. The house convention, and the one
used in 17b and everywhere after, puts the basis of the *source* on top.

Every occurrence in that proof was swapped the same way, so the argument was
internally consistent and read perfectly well. That is why it survived the
first audit. Each matrix in it named the wrong map.

Two more things there: statement **(b)** of that proposition needs different
shapes from **(a)**, since `A` and `B` must be summable, but its proof inherited
the maps fixed for **(a)**, so `T_C` quietly changed from `K^q -> K^p` into
`K^q -> K^n` halfway down. And Prop. 17.a.6 stood with neither a proof nor an
exercise, although the notes mark four other statements of that section
\qt{Exc.} and not this one.

### Ch. 17b, two slips in the bookkeeping of bases

The proof of Cor. 17.b.1 ends by saying the inverse of
`[\id_V]_{\mathcal{B}}^{\mathcal{B}'}` is
`([\id_V]_{\mathcal{B}'}^{\mathcal{B}})^{-1}`, one inverse too many.

More seriously, in the proof of Cor. 17.b.7 the left factor was written
`[\id_{K^m}]_{\mathcal{E}_m}^{\mathcal{C}}`, whose bases do not meet those of
the middle factor the way the composition rule requires. **The printed product
does not compose**, and the matrix named `P` was the inverse of the one meant.
The solution to Exercise **(b)** further down the same file independently
arrives at the correct `[\id_{K^m}]_{\mathcal{C}}^{\mathcal{E}_m}`.

### Chs. 17c and 17d, nothing wrong

Both are sound. What they had were steps taken silently: eight of them across
the two chapters now name the result they rest on. The most substantive is the
middle link of the equivalence chain in Prop. 17.d.3, which needs *two nested
subspaces of equal finite dimension coincide*; without it, equal dimensions of
the two spans does not put `b` in the smaller one.

Ch. 17d also had the ch. 16 pattern again: the map `\Phi` sending a choice of
free variables to the solution it determines was defined in running prose, with
Prop. 17.d.1 standing directly underneath as a statement about it. It has its
own unnumbered definition now.

### Ch. 17e, a product that does not compose, and the first `ai` result

**The size mismatch.** The three types of elementary matrix are defined in
`\M_{n x n}(K)`, which is what Lemma 17.e.1 needs, since it multiplies
`A \in \M_{n x p}(K)` from the *left*. The `importantremark` on column
operations that follows then multiplies the same `A` from the *right* by the
same matrices. `A \cdot Q_{ij}(\alpha)` is defined only for a `p x p` factor,
so **none of its three products exists unless `n = p`**. This is the ch. 17b
failure mode again, a printed product that does not compose, and it is invisible
to `check-repmatrix.pl`, which only knows about representation matrices. The
remark now states that its elementary matrices are those of `\M_{p x p}(K)`.
The mathematics of the three statements was right; only the sizes were.

**The first `ai` result of the pass.** Both theorems of the chapter lean on
*`A \in \M_{n x n}(K)` is invertible if and only if `\rank(A) = n`*, in opposite
directions: the proof of Thm. 17.e.3 opens with \qt{`A` is invertible, and hence
`\rank(A) = n`}, and the proof of Thm. 17.e.4 closes with the converse. Neither
direction is stated anywhere in the book; each is assembled on the spot out of
Lemma 17.c.3, Cor. 15.b.10 and Prop. 12.2. Because the equivalence is nowhere in
the notes, it became `aiprop:invertible_iff_full_rank` rather than a
`proposition*`, the first time rule 3 has pointed that way. It is `\cref`-able
like any numbered statement and runs on the `ai` counter, so 17.e.1 to 17.e.5
did not move.

**Seven silent steps** now name their reason: the existence of the row-reduced
echelon form; the invariance of rank under row operations, twice; the fact that
the only `n x n` row-reduced echelon matrix of rank `n` is `I_n`, which was
asserted flat and now has the pivot-counting argument behind it; the passage
from left-multiplication by a chain of elementary matrices to a sequence of row
operations, once in each direction of Thm. 17.e.4; and the order reversal in
inverting a product.

**A gap between a statement and its own proof.** Thm. 17.e.3 asks for
`k >= 1`, but its proof takes the elementary matrices from Gauss elimination,
which performs no operation at all when `A = I_n` and so yields `k = 0`. The
proof now closes that with `T_1 := S_1(1) = I_n`, an elementary matrix of Type
III because `1 != 0`.

**Presentation, where it obscured the logic.** The proof after the column
operations remark argues both that remark and the lemma above it, and its title
now says so, since an untitled `proof` sitting under the remark reads as a proof
of the remark alone. And where it said \qt{But taking the transpose again},
nothing was being transposed: the step is the observation that the rows of
`A\transp` are the columns of `A`. The logic was right either way. One arithmetic
slip in a solution written by an earlier pass: `P_{ij} = I_n - E_{ii} - E_{jj} +
E_{ij} + E_{ji}` involves four matrix units, not five.

## Tooling

### `tools/check-repmatrix.pl`

Written during this pass, after ch. 17a and 17b each turned up an index error.
It decides the one thing about representation matrices that is mechanically
decidable: **in a product, the superscript of the left factor must equal the
subscript of the right one**, because the bases meet diagonally. Anything else
either is a typo or does not compose.

```bash
perl tools/check-repmatrix.pl
```

It was validated against the pre-fix files before being trusted: it finds all
seven swapped indices in the proof of Prop. 17.a.2 and the wrong `P` in the
proof of Cor. 17.b.7. Note that the first version **missed** the 17b one,
because `\underbrace{...}_{=: P}` labels sit between the two factors and contain
an `=`, which made the pair look unclassifiable; the checker now strips those
labels before judging a gap. A checker that reports zero is worth distrusting
until it has been shown to find a known bug.

Current state of the book: **49 adjacent products checked, 0 mismatches.** The
21 pairs it skips are prose (\qt{$[S]$ and $[T]$}) rather than products; the one
genuine product among them, in the determinant of an endomorphism in ch. 20, was
checked by hand and is right.

### The build and check recipe

**Do not build through the Bash tool.** Every `latexmk` started from Bash leaves
a `latexmk`/`pdflatex`/`perl` trio running after the call returns. Those hold
`en-linalg-2.aux` and `.toc` open, and when they are eventually killed they
leave the files truncated or full of NUL bytes, at which point the next build
dies on \qt{Text line contains an invalid character} or \qt{File ended while
scanning use of `\@writefile`} while reading the book's own aux. This cost half a
dozen rebuilds in one session before the cause was found.

Build from PowerShell instead, which waits properly and leaves nothing behind:

```powershell
Get-Process | Where-Object { $_.ProcessName -match 'pdflatex|latexmk|perl' } |
  Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 3
Remove-Item en-linalg-2.aux, en-linalg-2.toc, en-linalg-2.out, `
            en-linalg-2.fls, en-linalg-2.fdb_latexmk -Force -ErrorAction SilentlyContinue
$p = Start-Process -FilePath "latexmk" `
  -ArgumentList "-pdf","-interaction=batchmode","en-linalg-2.tex" `
  -NoNewWindow -Wait -PassThru `
  -RedirectStandardOutput "$env:TEMP\lmk.out" -RedirectStandardError "$env:TEMP\lmk.err"
$deadline = (Get-Date).AddMinutes(8)
while ((Get-Process | Where-Object { $_.ProcessName -match 'pdflatex|latexmk' }) -and (Get-Date) -lt $deadline) {
  Start-Sleep -Seconds 3
}
Start-Sleep -Seconds 2
"exit=$($p.ExitCode)"
(Select-String -Path en-linalg-2.log -Pattern "Output written on en-linalg" -Encoding utf8 | Select-Object -Last 1).Line
"overfull=" + (Select-String -Path en-linalg-2.log -Pattern "Overfull .hbox"   -Encoding utf8 | Measure-Object).Count
"undef="    + (Select-String -Path en-linalg-2.log -Pattern "undefined|multiply.defined" -Encoding utf8 | Measure-Object).Count
"errors="   + (Select-String -Path en-linalg-2.log -Pattern "^! "               -Encoding utf8 | Measure-Object).Count
```

**Both halves matter.** The clean at the top removes an aux that an earlier
broken run may have left truncated. The wait loop at the bottom is there because
`Start-Process -Wait` returns when `latexmk` exits, while its `pdflatex` child
can still be writing the log: without the loop, the counts are read off a
half-written log and the run looks like a failure with a thousand unresolved
references. Read the counts only after the loop, and treat `errors=0` together
with `exit=0` as the pass condition. The two checkers may still be run from
Bash; they only read files.

Then `bash tools/check-crefs.sh` and `perl tools/check-repmatrix.pl`. The
baseline is **3 overfull hboxes** and no undefined or multiply-defined
references; anything above that is new. Count them with
`grep -c "Overfull .hbox" en-linalg-2.log`.

### A trap worth knowing

**The Bash tool halves backslashes in every argument, not just in heredocs.**
`grep '\\mathcal'` and `perl -ne '/\\rank/'` both silently match *nothing*,
because perl receives `\r`. This makes a search look clean when it is not, and
it cost two false \qt{no matches} during this pass. Use the Grep tool for
searching, and put any perl beyond a trivial one-liner into a file and run
`perl thatfile.pl`. `perl` is on PATH because latexmk needs it; `python` is not.

**The same halving silently corrupts LaTeX written through a heredoc.** Every
`\\` row separator inside `cat >> file <<'EOF' ... EOF` arrives as a single `\`,
which LaTeX reads as an inter-word space: the matrix typesets as one long row,
nothing is reported, and the build stays clean. Four matrices in the AI-Notes of
chs. 24, 25 and 26 shipped that way before the defect was noticed, in ch. 1,
only because a mangled `pmatrix` finally overflowed the margin and pushed the
overfull-hbox count above the baseline of three. **Any block containing `\\`
must go through the Write or Edit tools.** Sweep for survivors with the Grep
tool and the pattern `matrix\}[^$]*[^\\]\\ `.

**Two more build hazards on this machine.** A failed `pdflatex` run can leave
`en-linalg-2.aux` truncated, and the next run then dies with
\qt{Missing \\begin\{document\}} or a runaway `\@newl@bel` argument; delete the
`.aux`, `.toc` and `.out` and build again. And a hung `latexmk`/`pdflatex`/`perl`
chain keeps those files open, so `rm` reports \qt{Device or resource busy}; check
with `Get-Process` and stop the three processes before retrying. Neither is a
LaTeX error, and neither is worth debugging as one.

## Standing decisions taken during this pass

- **`\rankcol` and `\rankrow`** were added to the preamble next to `\rank`, and
  replace the spelled-out `\rank_{\text{col}}` in 56 places across chs. 13, 17b,
  17c and 17d, so the two can no longer drift apart typographically.
- ~~**A `remark` that is really a proposition becomes `proposition*`.**~~
  **Revoked by the user on 2026-08-26: \qt{pls dont change remark to theorem}.**
  A Remark keeps its Remark. The premise of the old rule was that a `remark`
  was unnumbered and therefore not citable, which is simply false:
  `en-linalg-2.tex:505` declares it `\newtheorem{remark}{Remark}[chapter]`, so
  it carries a number on a counter of its own, reset per chapter, with its
  `\crefname` registered at `:578`. A `\label` placed inside a Remark where it
  stands takes the ordinary `\cref` and prints \qt{Remark 24.2}, and inserting
  one never disturbs the Theorem/Lemma/Definition sequence. The promotion buys
  a citation that was already free, at the cost of rewriting the author's
  presentation. The two conversions made in ch. 17a stand as they are, but no
  further ones are to be made; rule 3 above and `gemini.md` now say so.

### Ch. 18, five results nobody could cite

**Nothing in ch. 18 is false.** It is the biggest chapter the pass has met,
three lectures in one file (18.a on $\Hom$, duals and biduals; 18.b on direct
sums; 18.c on quotients), and the source-verification pass had already been
through it. What the rigour pass found was of a different kind.

**Five numbered results of Prof. Biran's carried no `\label` at all**, so
nothing in the book could cite them: 18.a.3, 18.a.5, 18.a.11, 18.c.6 and
18.c.8. Two of them were being cited already, in words instead of by reference:
the proof of 18.a.6 runs `dim V* = dim Hom(V,K) = dim V . dim K` on 18.a.3
without naming it, and the proof of 18.c.8 appeals twice to \qt{the theorem
about the universal property of quotient spaces}, which is 18.c.6 directly
above it. All five are labelled now; the aux file confirms the printed numbers
18.a.1--18.a.12, 18.b.1--18.b.2 and 18.c.1--18.c.8 are unchanged.

Worth having a script for: `perl` over the file, flagging every
`\begin{theorem|lemma|proposition|corollary|definition}` with no `\label{` in
the next three lines. That is what found these, and it takes seconds. Nothing
in ch. 16 or 17 was missing a label, so this is the first chapter where it paid.

**A proof that stops one line early.** Lemma 18.a.11 computes the coordinates
of `S*(w_j*)` in `B*`, observes they form column `j` of `A^T`, and ends there,
without ever saying that this identifies `[S*]_{B*}^{C*}` with `A^T`, which is
the claim. The concluding sentence is supplied.

**Two things stated in running prose**, the ch. 16 pattern again, both now
unnumbered so nothing moves. The functionals `v_i^*`, with Lemma 18.a.7
standing directly underneath as a statement about them, were defined in a
paragraph. And the naturality of `\tau` was asserted as a commutative square
alone, with no statement attached to it and no proof; it is a `proposition*`
now, with the four-line verification that unwinds the definitions.

**Some fifteen silent steps** name their reason. The ones with content: that
isomorphic spaces have equal dimension; the two halves of Thm. 15.a.3, used
three times; that `n` spanning vectors in an `n`-dimensional space are a basis;
that injective plus equal finite dimension gives an isomorphism, which finishes
Thm. 18.a.12; the column description of a representation matrix, twice; and the
basis extension behind 18.c.8 **(c)**. Cor. 18.a.4 appealed to \qt{a
fundamental result from Linear Algebra I} for the matrix of a composition,
which is the composition rule earlier in this same book.

Also: Prop. 18.b.2 said that `U'` being a complement \qt{implies} `U + U' = V`
and `U ∩ U' = {0}`, where those two conditions *are* the definition of a
complement, not a consequence of it.

### Ch. 10a, a proof that disagrees with the two remarks explaining it

The pass came back to the bases chapters, the original starting point before
the redirect to ch. 16.

**The exchange ran backwards.** The proof of the Steinitz Exchange Theorem
(10.a.7) inserted each `u_j` at the *front* of the list, so the independent head
accumulated in reverse as `u_j, ..., u_1` and the proof closed on
`u_{n+1}, u_n, ..., u_1`. Both remarks sitting underneath it use the forward
order: `rem:steinitz_general_step` says the list reads
`u_1, ..., u_{j-1}, w_1, ...` and inserts `u_j` after `u_{j-1}`, and
`rem:steinitz_stronger_form` ends at `u_1, ..., u_m, v_{i_1}, ...`. Both of
those had been **restored from the notes** by the source-verification pass, so
the transcript's proof was the odd one out. Nothing was false either way, since
neither independence nor span depends on the order, but a proof that
contradicts the two remarks written to explain it is not something a reader can
be asked to reconcile. The proof now follows the notes.

This is the one case so far where the tex-only rule was not enough. Both
orderings are internally consistent, so the LaTeX alone cannot say which is the
deviation; only the scan can. Two pages of `source/10.basis.a.v03.pdf` settled
it. Worth remembering as the shape of question that justifies opening a scan
during this pass: not \qt{is this right} but \qt{which of these two right things
is his}.

**`\Sp(\emptyset)` written as `\emptyset`.** Step 1 of the same proof excluded
`u_1` as the droppable vector by noting that the span of the vectors preceding
it is empty. That span is `\Sp(\emptyset) = \{0_V\}` (ch. 8,
`rem:span_of_empty_set`), not `\emptyset`, and the difference is the entire
argument: the step works because `u_1 \ne 0_V`, which is a statement about
`\{0_V\}` and vacuous about `\emptyset`.

**The ch. 16 pattern again.** Finitely supported functions and the linear
combination `\sum_{u \in S} c(u) u` indexed by an arbitrary `S` were introduced
in running prose under no heading, although Prop. 10.a.2 directly above is a
statement about exactly that notion and its proof uses the sum throughout. The
scan confirms the notion is Prof. Biran's own, and that he writes \qt{Def.} on
that same page when he means one, so the omission is real and rule 3 points at
`definition*`. It is now the unnumbered Definition on
`\cpageref{def:finitely_supported}`.

**Seven silent steps** name their reason, and the proof of Lemma A (10.a.3)
stopped at `V \subseteq \Sp(u, v_2, ..., v_n)` without the reverse inclusion,
so it never actually concluded that the new list spans `V`.

**The first exercise solution in the early chapters.** Exercise 10.1 asks what
happens when the drop index is `j = 1`. The answer is that it happens exactly
when `v_1 = 0_V`, which is precisely the case Step 1 of the Steinitz proof has
to exclude; the solution is written up. Chs. 1--11 have 19 exercises and no
solutions at all, so this is the first of a backlog that the pass will meet
again in ch. 11.

### Ch. 11, the first outright false statements of the pass

Chs. 16 to 18 turned up index errors, products that do not compose and steps
without reasons, but no printed sentence that was simply untrue. Ch. 11 has two.

**The zero space.** The remark defining `\dim \{0_V\} = 0` opened with \qt{its
only spanning set is `\{0_V\}`}, and then said in its very next sentence that
the empty set spans it too. The zero space has exactly two subsets and **both**
span it; what separates them is that `\{0_V\}` is dependent (ch. 9,
`lem:independence_basics` **(d)**) and `\emptyset` is not
(`rem:empty_list_independent`). That is the whole content of the remark, and the
opening sentence denied it.

**`\dim K^S = |S|`, stated for an arbitrary set.** `K^S` is the *full* function
space of `ex:function_space` in ch. 7, not the finitely supported one, and the
formula holds only for finite `S`. The cleanest way to see the failure stays
inside the book: for infinite `S` the space is not finite-dimensional, so
`def:dimension` assigns it `\infty` and the equation does not typecheck at all,
the book's `\dim` having no values other than `\mathbb{Z}_{\ge 0}` and
`\infty`. Concretely the indicator functions `f_s` remain independent but stop
spanning, since a linear combination is a finite sum; ch. 9's
`exc:k_infinity_independent` already records exactly this for sequences and had
been sitting there unconnected. The example now reads \qt{finite `S`} and the
remark below it carries the infinite case. Worth noting that the surrounding
material was already right: the exercise asks for a basis *when `S` is finite*,
and the remark already said `K^S` is infinite-dimensional. Only the displayed
formula overreached.

**A definition with a free symbol.** `def:dimension` read
\qt{$\dim V := n \in \mathbb{Z}_{\ge 0}$} with `n` introduced nowhere. The basis
whose elements `n` counts is now named.

**Lemma D' inherited the ch. 10a bug.** Its proof inserted each `u_j` at the
front, the same reversed bookkeeping, and additionally described ejecting the
redundant `v_k` as restoring independence. It does not. Dropping a redundant
vector preserves the span and restores the length to `n`; it says nothing about
independence, which may still fail, and does whenever the original spanning list
was redundant to begin with. What the procedure maintains is that the `u`'s at
the head are independent, which is what makes `lem:drop_index_beyond_head` bite.

**One gap flagged rather than closed.** `lem:targeted_redundancy` (10.a.4)
attaches its second assertion to the one index its proof produces, while
`lem:spanning_list_contains_basis` drops whichever index its step happens to be
at. Prof. Biran makes the same small leap. The two-inclusion argument uses only
the predecessor property and never how the index was found, so a parenthetical
says so rather than manufacturing an `ai` lemma for something this routine.

Also: Exercise 11.1 was unlabelled and is now written up, and six silent steps
cite their reason, among them `thm:steinitz` itself, which Statements 2 and 3 of
the Basis Theorem had invoked as \qt{Lemma D} in words only.

### Ch. 12, the theorem the whole book leans on and nobody proved

**The basis extension property has no proof anywhere in the book.** It is item
**(2)** of `sum:finite_dim_properties`, a `summary` environment recording two
principles as a recollection of the previous lecture, and the notes prove
neither. Nor does anything else: the property is used in chs. 14, 15a, 17b, 18,
21, 22b, 26 and 28b, some ten times, occasionally credited in passing to
\qt{the Steinitz Exchange Lemma}, and never derived. Item **(1)** is
`lem:spanning_list_contains_basis` outright.

Both now have their derivation, from `lem:spanning_list_contains_basis` and
`lem:strong_steinitz`. The one trap is **circularity**: the obvious route to
item **(2)** runs through `thm:basis_equivalent_characterizations` (12.1), which
sits directly below the summary and whose own proof appeals to both items. The
derivation therefore goes to `lem:spanning_list_contains_basis` directly: the
extended list spans and has exactly `d` entries, so the basis it contains is all
of it. A comment in the file records why the short route is not taken, so a
later pass does not \qt{simplify} it back into a circle.

This is the largest single gap the pass has found. It is also a good argument
for reading the early chapters: the property looks so standard that ten later
chapters use it without blinking, and the transcript's own citations of it drift
between \qt{the Steinitz Exchange Lemma} and nothing at all.

Also in ch. 12: the converse half of the equality claim in
`prop:subspace_dimension_constraints` opened with \qt{Furthermore}, which
announces an additional fact rather than the converse the sentence above it had
just set up. And the proof of the same proposition restates
`thm:wrong_length_lists` **(2)** in words although it stands two results above.

### Ch. 13, three arguments that stop one step short

Nothing false. The chapter had already been through the source pass thoroughly,
`ailem:column_relations_preserved` included. What it had were arguments ending
just before the line the reader needs:

- the worked span computation in `ex:span_calc` stopped one operation before a
  row-reduced echelon form, the entry above the second pivot never being
  cleared, although the paragraph setting up the method says the reduction goes
  that far. The step is added, and it lets the solution be read off;
- in `thm:coordinate_constraints` **(b)**, the strictness of the inclusion
  rested on row operations being \qt{reversible and hence unable to annihilate a
  whole row}, which is right but leaves the reader to reconstruct why: those
  operations act on the last column as a bijection of `K^m`, and a coordinate
  vanishing identically would confine the image to a proper subspace;
- in `thm:row_basis`, that the non-zero rows of `B` span `\RowS(B)` was credited
  to the definition, whereas `def:matrix_subspaces` spans **all** the rows.

Left alone deliberately: `\rank(A)` for a matrix is named inside the statement
of `thm:rank_equality` rather than in a definition of its own. The notion stays
citable, and nothing later appeals to a definition of matrix rank that does not
exist; the two \qt{by definition, `\rank`} in ch. 17c mean the rank of a linear
map, which `def:rank_linear_map` supplies.

### Ch. 14, one more false statement

**`rem:complement_not_unique` needs a hypothesis it did not state.** It said
that a subspace `U \subsetneq V` has many complements. The zero subspace has
exactly one, namely `W = V`, since `\{0_V\} + W = W`; there is nothing to
choose. The remark needs `\{0_V\} \subsetneq U \subsetneq V`. The figure drawn
beside it already assumed as much, taking for `U` a line rather than a point,
which is the sort of disagreement between a picture and its caption that is
worth checking for elsewhere.

The proof of `prop:properties_of_sums` **(b)** also opened by claiming that
`U + W` is generated by the combined family \qt{by definition}. It is not: that
is exactly what `exc:combined_family_spans` asks the reader to check, following
the notes' own \qt{exc. check this!}. A proof should not assert as definitional
the thing it has just set as an exercise.

And `prop:existence_complement` is the first place where ch. 12's new proof pays
off: it extended a basis \qt{by the Steinitz Exchange Lemma}, and now names item
**(2)** of `sum:finite_dim_properties`. It also needs `U` to be
finite-dimensional before it can speak of a basis of `U`, which is
`prop:subspace_dimension_constraints`.

### Ch. 24, the identity that carries the Spectral Theorem

**Nothing false.** One thing genuinely missing, and it is the engine of the
chapter. The proof of the Spectral Theorem over $\mathbb{C}$ reads
`||Tv_1||^2 = |a_11|^2`, then `||T*v_1||^2 = sum_k |a_1k|^2`, then the same
twice more for `v_2`, each time on the strength of \qt{$\mathcal{B}$ is
orthonormal}. The fact underneath, that coordinates taken in an orthonormal
basis compute the norm, **is stated nowhere in the book**: chs. 22a and 22b
build orthonormal bases at length, prove Pythagoras for two vectors, and never
write the $n$-term version. It is now `ailem:norm_in_orthonormal_basis`, lifted
out of the proof so the four steps can point at it. `ai`, since the statement
appears nowhere in the notes, only inside this one argument.

`prop:matrix_representation_adjoint` (23.a.4), the identity
`[T*]_B^B = ([T]_B^B)*`, is used **five times** in this chapter and credited
none of them, although it is exactly where orthonormality enters each argument.
Passing from an equality of representation matrices to an equality of maps,
three times, is `thm:homomorphism_isomorphism`.

The four points of the proof sketch of `thm:spectral_thm_matrices` were asserted
with no reason at all, while the solution below them leans on every one; two
citations cover all four, `cor:adjoint_matrix_map` and
`def:orthogonal_unitary_matrices`. `cor:spectral_thm_real_trigonalizable` had no
proof, only the remark above it observing that $K = \mathbb{C}$ was used once;
the proof now checks that claim result by result.

Two arguments stopping a step short: the induction closing the proof of
`thm:spectral_thm_c` is not a repetition of its first step, since at stage $k$
it needs stages $1, \dots, k-1$ to have cleared the entries above the $k$-th
diagonal entry, which is what makes `||Tv_k||^2 = |a_kk|^2`; and the proof of
`lem:self_adj_properties` **(b)** passes from $P_A$ to $P_T$ twice without
naming `rem:char_poly_well_defined`.

A standing convention was made explicit: the chapter says \qt{inner product
space} throughout while using $T^*$, and ch. 23a's adjoint exists only in finite
dimension.

### Ch. 25, a proof that covers only half its own hypothesis

**The one real gap: `thm:isometry_equivalences` **(b)** $\Rightarrow$ **(a)** is
proved only over $\mathbb{R}$.** The theorem is stated over $\mathbb{R}$ and
over $\mathbb{C}$ alike, and the proof reaches for `exc:polarization`, whose
part **(a)** begins \qt{Let $V$ be a Euclidean space}. Part **(b)** of that same
exercise asks the reader to find the Hermitian analogue, and ch. 22a's solutions
do work it out, so the complex half was available all along and simply never
invoked. The proof now says which identity carries which field.

**Two statements of his in bare running prose.** The names \qt{orthogonal
endomorphism} and \qt{unitary endomorphism} were introduced in one sentence
between 25.a.2 and 25.a.3, and are then used by 25.a.3, 25.a.6, 25.a.8 and both
exercises. And $\det A = \pm 1$ on $\Orth(n)$, $|\det A| = 1$ on $\Unit(n)$, was
a paragraph that `cor:2d_isometry_matrix` had to cite *in words*, as \qt{the
computation following \cref{prop:orth_unitary_matrix_rep}}, which is the clearest
possible sign that a statement wants an environment. Both are unnumbered now,
`def:orthogonal_unitary_endomorphism` and `prop:det_orth_unit_matrices`, the
second keeping the existing paragraph as its proof; 25.a.1--25.a.10 confirmed
unmoved in the aux file.

**Silent steps now named**: `lem:basic_properties_inner_prod` **(c)** for
`<v,e_j> = <v,T*Te_j>` for all `v` giving `T*Te_j = e_j`; the uniqueness half of
`thm:existence_uniqueness_linear_map` for concluding `T*T = id` from agreement
on a basis; `thm:unique_det` for `det(conj A) = conj(det A)`, the one equality of
the unitary determinant chain that is not simply multiplicativity;
`aiprop:eigenvalue_iff_root` for turning the odd-degree root into an eigenvalue
in `prop:classification_so3`. The coordinate map $\Phi$ in the proof of
`cor:2d_isometry_matrix` was called an isometry with no argument; ch. 24's
`ailem:norm_in_orthonormal_basis` **(a)** is exactly the missing half, which is
the first time the new `ai` lemma has paid for itself outside its own chapter.

### Ch. 26, the square root that was not known to exist

Two pages, one theorem, nothing false, and the source pass had already filled in
most of the obvious holes. The step that was still doing real work unannounced:
the proof sets $\lambda_j := +\sqrt{\eta_j}$ where the $\eta_j$ are the diagonal
entries of $Q^{-1} B Q$, having just proved that the **eigenvalues** of
$B := A^* A$ are positive reals. The two lists coincide because $Q^{-1} B Q$ and
$B$ are similar, so `lem:properties_char_poly` **(e)** and
`aiprop:eigenvalue_iff_root` connect them; until that is said, the square root is
not known to be defined.

Three smaller ones: $B$ being self adjoint is
`prop:properties_adjoint_matrix` **(e)** and **(c)**, and moving from the matrix
$B$ to the endomorphism $T_B$, which is what `lem:self_adj_properties` actually
speaks about, is `cor:adjoint_matrix_map`; the computation of $C^* C$ takes the
adjoints of a real diagonal matrix and of $Q$ silently, the second being
$Q^* = Q^{-1}$; and $n \le m$, announced in the proof's first line, is
`thm:rank_nullity` with `prop:subspace_dimension_constraints`.

### Ch. 27, two more inverted indices

**The second real error of the pass, and it is the same error twice.** Both are
transition matrices with the basis of the target on top, and both sit outside any
product, so `tools/check-repmatrix.pl` cannot see them:

- the proof of `thm:sylvesters_inertia` introduces the orthogonal $P$ as
  `[id]_{C''}^{C'} = P`, while its own next sentence says
  `v''_j = sum_i P_ij v'_i`, which is `[id]_{C'}^{C''}`, and while
  `[B]_{C''} = P^T A P` holds for that reading and no other;
- the proof of `thm:sylvesters_criterion` writes `S = [id]_{C'}^{C}` for the
  matrix that `[B]_{C'} = S^T [B]_C S` forces to be `[id]_{C}^{C'}`.

`lem:change_of_basis_bilinear` itself, the outline of `thm:sylvesters_euclidean`
and the solution to `exc:sylvester_criterion_forward` were checked against the
same convention and are right, so the chapter was not systematically swapped the
way ch. 17a's Prop. 17.a.2 was.

**Two results asserted without proof.** The Polarization Identity, unnumbered on
`\cpageref{thm:polarization_identity_bilinear}`, carried none although it starts
the induction of `thm:diagonalization_symmetric_bilinear`; it is two expansions.
And `lem:matrix_rep_bilinear_form` proves only that a matrix representation
*exists*, then calls it **the** matrix representation: uniqueness is what lets
the next proof read `([B]_C)_{jk} = B(v_j, v_k)` off the name in its first line.

**A step whose point was the half that was missing.** The Remark before the
Conclusion shows that `(B + B^T)/2` gives the same quadratic form as `B`, without
computing it and without saying that this matrix is *symmetric*, which is the
entire content of the Conclusion underneath it.

Flagged rather than changed: in the Example of standard forms the letter `B` is
both the matrix and the form it defines, so the defining line reads
`B(v,w) := v^T B w`. The same species as ch. 17c's `P`; a parenthetical now says
which is which.

### Ch. 28a, the corollary that computes the wrong object

Nothing false, and the source pass had already written up all six \qt{exc.}
marks. What the rigour pass found were two silent passages between $T$ and its
representation matrix, in the proof of `cor:multiplicities_min_poly_jnf`. The
first, `m_g(T, λ) = m_g(A, λ)`, is `prop:matrix_evaluation` with
`prop:coordinate_map_isomorphism`. The second is more serious: the whole second
half of the proof works with the matrix `A` and concludes a statement about
$\mu_T$, and the two minimal polynomials agree only because
`q(A) = [q(T)]_B^B` for every polynomial `q`, the representation map being a
ring homomorphism and injective by `thm:homomorphism_isomorphism`. Without that
sentence the corollary computes the minimal polynomial of the wrong object.

Also: `\Spec` is used exactly once in the whole book, in the statement of that
corollary, and defined nowhere; the operator is declared in the preamble and the
word \qt{spectrum} is explained only in ch. 24's opening AI-Note. The statement
now says which set it means.

### Ch. 28b, nothing false in nineteen pages

This file was transcribed from the scans by Opus 5 in the first place, with no
earlier transcription to audit, and it shows: the pass found nothing false and
no missing hypothesis. Five steps were resting on an unstated reason and now name
it, the first of them load-bearing:

- that **a divisor of a split polynomial splits**, in
  `lem:char_poly_on_generalized_eigenspace`. Without it, \qt{$P_{T_\lambda}$ has
  no zero other than $\lambda$} does not give $P_{T_\lambda} = (\lambda - x)^m$,
  which is the whole assertion;
- criterion **(b)** of `ex:direct_sum_conditions`, which is what the induction of
  `lem:generalized_eigenspaces_direct_sum` actually verifies;
- `prop:block_matrix` with `rem:char_poly_well_defined`, for multiplying the
  characteristic polynomials of the summands back together in
  `cor:nilpotency_on_generalized_eigenspace`;
- `exc:nilpotent_properties` **(d)**, for the splitting of $P_{N_\lambda}$;
- in the uniqueness proof, `rem:char_poly_well_defined` and
  `lem:properties_char_poly` **(c)** for the two identities the entire count
  starts from, plus the recurring passage $\dim \ker S^k = \dim \ker C^k$ from an
  endomorphism to a representation matrix.

The chapter's `ainote` was written the way the corrected rule asks for: it gives
the architecture of the two proofs, existence as a reduction plus a chain
construction, uniqueness as a basis-free count of $\dim \ker(T - \lambda)^r$, and
only then records what the pass named.

### Ch. 1, an argument that appeals to growth and does not need to

The chapter rules out arithmetic Fibonacci sequences in one line: the difference
of consecutive terms is $a_{n-2}$, which \qt{grows and cannot remain constant}.
The conclusion is right and the reason is not the one that works. What the two
displays give is $a_{n-2} = d$ for every $n \ge 2$, that is, that the sequence is
*constant*; a constant sequence obeys the recurrence only when $d = d + d$, so
$d = 0$. No growth estimate is involved, and the argument covers sequences with
negative terms, for which nothing grows. Prof. Biran evidently intends the gap to
be filled: it is exercise **(d)** of his own closing list.

**The chapter's two opening Definitions carried no `\label` at all**, so nothing
could cite the definition of a Fibonacci sequence or of $\Fib$. Both do now.

**And the seven exercises are written up**, which is the first instalment of the
open question below about chs. 1--9. They are worth the space: the continued
fraction of exercise **(c)** turns out to have the Fibonacci quotients as its
convergents, so it and exercise **(e)** are the same statement twice, and the
matrix identity behind Cassini is the one the eigenvalue chapters return to.

The chapter's `ainote` was written the way the corrected rule asks: it says what
the chapter is doing, namely replacing a question about one number by a question
about the space of all such sequences, before recording what the pass changed.

### Ch. 2, a proposition whose proof was an exercise nobody solved

`prop:contrapositive` is stated and then not proved: the chapter defers it to
`exer:de_morgan`, and chs. 1--9 carry no solutions, so it stood unproved while
being the shape of a large share of the proofs that follow. The exercise, which
also asks for double negation and the two De Morgan laws, is now written up, with
all four truth tables.

**Five Definitions and one Proposition carried no `\label`**: mathematical
statement, implication, equivalence, quantifiers, unique existence, and
\qt{Negating Quantifiers}. The last three are used constantly in later chapters,
`\exists!` most of all, and none of them could be cited.

Two smaller things. The equivalence $(x^2 > 0) \iff (x \ne 0)$ in
`ex:equivalences` has no domain attached, and it is a fact about $\mathbb{R}$
rather than about logic. And `exer:de_morgan` writes $=$ between statements where
the chapter has just defined $\iff$ for exactly that relation; a parenthetical now
says the two are the same thing here.

### Ch. 3, the four operations the book runs on, defined in a bare list

Intersection, union, difference and complement are introduced in a plain
`enumerate` in running prose, with nothing to cite and with `=` where each line
is a definition and wants `:=`. They are now `def:set_operations`, unnumbered,
the four naming lines kept verbatim.

**Both `claim*` blocks carried no proof.** That $\emptyset \subseteq Q$ is the
first place in the book where the vacuous truth of an implication with a false
premise does real work rather than producing a joke about flat Earths, and it is
worth saying where it happens. And the Russell claim, that neither $S$ nor $R$ is
a set, needs one further step than the paradox itself: $R$ is not a set because
\qt{$R \in R$} would then be a statement with no truth value, and $S$ is not one
because $R$ could be carved out of it.

Six Definitions carried no `\label`, among them subset, Cartesian product, power
set and cardinality, which the rest of the book uses on nearly every page. The
power-set exercise is written up.

### Ch. 4, the associativity nobody stated

**Composition is associative, and the book never says so.** Ch. 17a proves the
associativity of matrix multiplication with the words \qt{we rely on the
associativity of function composition, which states that
$(T_A \circ T_B) \circ T_C = T_A \circ (T_B \circ T_C)$}, and that statement
appears in no chapter. It is now `ailem:composition_associative`, in ch. 4 where
composition is defined, and ch. 17a cites it. An `ai` environment, since it is
nowhere in the notes: the same case as `aiprop:eigenvalue_iff_root` in ch. 21.

Seven Definitions carried no `\label`: map, image of a map, restriction,
injective/surjective/bijective, inverse map, image of a subset, inverse image of
a subset. The book's kernel is the inverse image of $\{0\}$ and its Rank-Nullity
theorem is about the first four, so these are among the most-used notions in it.

Nothing false. The partitions section, added by an earlier pass, is complete and
correct as it stands.

### Ch. 5, a theorem with nothing to decide, and no proof

`thm:fp_is_field` says \qt{$\mathbb{F}_p$ is a field if and only if $p$ is a
prime number}, and the definition two lines above it opens \qt{Let $p$ be a prime
number}. As written the theorem therefore has nothing to decide; it wants to be
read about $\mathbb{Z}/n\mathbb{Z}$ for an arbitrary modulus $n \ge 2$, and now
says so. It also carried no proof: the paragraph after it argues one direction,
and only for the single modulus $4$. The other direction, that a prime modulus
really does supply inverses, is Bézout, and it is the half that makes finite
fields exist at all.

The chapter's own `ainote` records that only the field axioms come from the
notes and everything after them is the transcript's. That makes an unproved
Theorem more serious rather than less: it is not something Prof. Biran asserted
and left, it is something the book asserted about itself.

### Ch. 6, nothing false in three long computations

The largest of the foundational chapters and the best-audited: an earlier pass
had already labelled every Definition and Theorem and had written the proof of
`thm:ero_preserve_solutions` as three `claim*` blocks. The rigour pass found
nothing false.

**All three worked examples were recomputed entry by entry**, and the final
answers substituted back into the original systems. They are correct, fractions
and all, including the six-step reduction of `ex:full_reduction` and the
consistency condition $b_3 - b_2 + 2b_1 = 0$ of `ex:consistency_conditions`.
Recorded here so that nobody redoes them.

What the chapter needed was pointers. The three examples and the augmented-matrix
Notation had no labels, and the closing sentence of the last one refers to
\qt{our \textbf{(c)} question} without saying where that question is or where it
is answered; it now names both, the list of goals and
`cor:non_homogeneous_solutions` in ch. 17d.

### Ch. 7, eight exercises, two claims and a question, all unanswered

Nothing false. What the chapter had was a great deal left open: eight exercises,
two `claim*` blocks with no proof (`claim:bounded_degree_subspace` and
`claim:matrix_space`), and a two-part `question` (`q:degree_exactly_d`) that is
never returned to. All of it is now written up.

Four of the exercises ask for the eight vector-space axioms in $K^n$,
$K^\infty$, $K^S$ and $K[x]$, and writing the verification out four times would
be worse than useless. They share one solution, which makes the actual reason
visible: all four are sets of $K$-valued functions on an index set with
operations defined index by index, so every axiom evaluates index by index into
one of the field axioms **(K1)**--**(K10)**. The matrix-space claim is the same
solution again with index set $\{1,\dots,m\} \times \{1,\dots,n\}$, which is also
why $\dim \M_{m \times n}(K) = mn$ later. The one genuine difference is $K[x]$,
where closure has to be checked because of the finite-support condition, and that
is exactly the distinction ch. 9's `exc:k_infinity_independent` turns on.

The answer to the question is worth having on the page: $\{f : \deg f = d\}$ is
never a subspace, while the coefficient-sum-zero set is, and the contrast is the
general one. A condition saying that a linear expression in the coefficients
*vanishes* always cuts out a subspace; one saying a coefficient *does not vanish*
never does.

A LaTeX trap met here: `$K[x]_d$` inside the optional argument of
`exercisesolution` ends the argument at the `]` of `K[x]`. Brace the whole
argument, or keep the title free of brackets.

### Ch. 8, five exercises, one of them load-bearing

Nothing false, and unusually well labelled already: every exercise had a label
and the chapter's own `ainote` records exactly which figures are the transcript's.
What was missing were the five solutions.

One of them carries the chapter's main claim. `exc:two_vectors_span_plane`, which
the notes mark \qt{Important}, is what justifies the words \qt{and no others} in
the Summary on `sum:subspaces_of_plane`: without it, nothing rules out a fourth
kind of subspace of $\mathbb{R}^2$. The solution proves it with explicit
coefficients rather than by citing `prop:inv_2x2`, which lives twelve chapters
later; the quantity $ad - bc$ appears, but as a computation, not as a
determinant.

The other four: `lem:span_of_finite_list`, where the content is that repetitions
and omissions are absorbed into the coefficients; the identification of $L_v$
with $\Sp(v)$; $K^n = \Sp(e_1, \dots, e_n)$, whose coefficients are visibly the
coordinates, which is what makes $\Phi_{\mathcal{B}}$ well defined in ch. 16; and
the finite-dimensionality of $K^n$, $\M_{m \times n}(K)$ and $K[x]_d$ together
with the failure of it for $K[x]$. That last argument is the one worth having on
the page: a finite spanning set has a maximal degree $N$, so it cannot reach
$x^{N+1}$, and the reason is that a linear combination is a finite sum, the point
of `rem:finite_sums_only`.

## Checked in ch. 17e and found correct

Recorded so that nobody re-derives them: `Q_{ij}(\alpha) = I_n + \alpha E_{ij}`
agrees with the row operation defining it, and the three `4 x 4` examples are
right. `Q_{ij}(\alpha)\transp = Q_{ji}(\alpha)`, and the row operation it
induces on `A\transp` is the right one; `P_{ij}` and `S_i(\alpha)` are
symmetric, which is why \qt{a similar logic} really does carry **(b')** and
**(c')**. The explicit form `P_{ij} = I_n - E_{ii} - E_{jj} + E_{ij} + E_{ji}`
is right, and so is the worked `2 x 2` inverse at the end, verified by
multiplying back. Lemma 17.e.2 needs `\alpha != 0` for
`S_i(\alpha)^{-1} = S_i(\alpha^{-1})`, and gets it from the Type III
definition. The telescoping in `A \cdot B = (T_1^{-1} ... T_k^{-1})(T_k ... T_1)`
is right.

One deviation that is deliberate and was left alone: this section writes
elementary row operations as `R_i + \alpha R_j -> R_i`, where `gemini.md` and
ch. 6 use `E_i`. The switch is Prof. Biran's own and is forced here, since
`E_{ij}` is already the matrix units of `not:matrix_units`. The chapter's
`ainote` records it.

## Open questions

- **Where next.** Chs. 10a to 18 are now done in one unbroken run, except for
  15a and 15b. Those two and ch. 19 onwards are what remain, plus chs. 1--9.
- **A check worth running elsewhere.** Ch. 14 turned up a remark whose figure
  assumed a hypothesis the remark itself had dropped. Where a chapter has a
  figure, read the caption against the statement it illustrates; the picture is
  often the more careful of the two.
- **Exercise solutions in chs. 1--9.** Those chapters carry 17 exercises between
  them and not one solution, while every chapter from 14 on has them. The single
  exercises in 10a and 11 are now written up. Whether the pass should also clear
  01--09 as it goes, or leave them, has not been decided.
- **Look for hand-drawn figures.** The user asked that Prof. Biran's own
  sketches be rendered in TikZ where the scans have them. Ch. 10a's scan is
  plain text on the pages read, and note that several TikZ figures already in the
  book are the transcription's inventions rather than his, so their presence
  proves nothing. Check the scan when a chapter's subject is geometric.
- `\qt{in \cpageref{...}}` prints \qt{in page 123}; it should be \qt{on}. The
  occurrences in chs. 18 and 10a are fixed. **One remains**, in
  `content/19-misc.tex:196`, in a chapter the pass has not reached. Fix it when
  it gets there, or sweep with `\bqt{in \\cpageref}` through the Grep tool (not
  through Bash, see the trap above).
- Ch. 17c calls a vector space `P` in Lemma 17.c.2 while `P` is an invertible
  matrix two statements later. Nothing is wrong and it was left alone
  deliberately, but the collision is a trap for the eye and is flagged in that
  file's `ainote`.
