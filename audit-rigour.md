# Rigour audit (reading the LaTeX alone)

Working notes for the second audit pass over this book. Branch
`review/verify-against-source`. Last updated after ch. 17d was pushed
(`eeb79e5`); the pass stopped part way into ch. 17e with **no edits made to
that file**.

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
3. **Only reach for `aidefinition` / `ailemma` / `aitheorem` when the statement
   is not Prof. Biran's at all.** Through ch. 17d, no such case arose: every
   addition was one of his own statements finally getting a home.
4. **Expand with parenthetical remarks.** `(i.e., ...)`, `(recall: ...)`,
   `(see ...)` add the reason for a step without rewording the sentence around
   it, which keeps the diff honest and the author's voice intact. A snappy
   second proof is welcome where one exists.
5. **Change prose only when the mathematics in it is wrong.** A word that
   carries mathematical content counts: replacing \qt{conversely} by \qt{in the
   other order} where nothing is converted is a correction, not a restyling.
6. **Provenance tags** as everywhere else in the book: `% Creator: Opus 5 (Max)`
   opens a block written in this pass, and `% Extractor: Gemini 3.1 Pro` closes
   it so the code that follows is attributed again.
7. **One chapter per commit**, build before committing, then push.

## Status

| Chapter | File | State |
|---|---|---|
| 16 | `content/16-linear-maps-and-bases.tex` | done, pushed (`185f340`) |
| 17a | `content/17a-matrices_a_matrix_multiplication.tex` | done, pushed (`932b403`, `15b15cd`) |
| 17b | `content/17b-matrices_b_change_of_basis.tex` | done, pushed (`0c1499c`) |
| 17c | `content/17c-matrices_c_column_rank_and_row_rank.tex` | done, pushed (`b9078db`) |
| 17d | `content/17d-matrices_d_more_on_matrices_and_lineq.tex` | done, pushed (`eeb79e5`) |
| 17e | `content/17e-matrices_e_elemntary_row_operations_revisited.tex` | **stopped part way through, no edits made** |
| 10a, 11 | the bases chapters | not started; these were the original starting point before the redirect to ch. 16 |
| 18 onwards | | not started |

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

```bash
latexmk -pdf -interaction=nonstopmode en-linalg-2.tex
```

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

## Standing decisions taken during this pass

- **`\rankcol` and `\rankrow`** were added to the preamble next to `\rank`, and
  replace the spelled-out `\rank_{\text{col}}` in 56 places across chs. 13, 17b,
  17c and 17d, so the two can no longer drift apart typographically.
- **A `remark` that is really a proposition becomes `proposition*`.** Applied in
  17a to the identity map being represented by `I_n` (which the notes mark
  \qt{Exc.}, so they ask for a proof of it) and to the uniqueness of the inverse
  matrix (whose proof follows it immediately). Both unnumbered, their references
  moved to `\cpageref` with descriptive names. Apply this per chapter as the
  audit reaches it, not as a blanket sweep: about eleven `remark` blocks in the
  book are followed by a `\begin{proof}`, and several of those are legitimate
  remarks sitting between a proposition and its proof.

## Where the pass stopped: ch. 17e

Read as far as Thm. 17.e.3, roughly the first 130 lines. **Nothing was changed
in the file.** The observations below are preliminary and none of them has been
verified to the standard of the chapters above; treat them as a starting point,
not as findings.

Checked and correct so far:

- `Q_{ij}(\alpha) = I_n + \alpha E_{ij}` agrees with the row operation that
  defines it, and the three `4 x 4` examples are right.
- In the proof, `Q_{ij}(\alpha)\transp = Q_{ji}(\alpha)` is correct, and the
  row operation it induces on `A\transp` is the right one.
- Thm. 17.e.3 with `k >= 1` is fine even for `A = I_n`, since `S_i(1) = I_n` is
  itself an elementary matrix.

Worth looking at:

- The `importantremark` on column operations sits **between Lemma 17.e.1 and its
  proof**, and the proof then argues statements **(a)** to **(c)** of the lemma
  and **(a')** to **(c')** of the remark. One `proof` environment covering two
  environments is at least confusing, and a reader cannot tell what the proof
  is attached to.
- The transpose argument in that proof takes the transpose twice and says so
  twice (\qt{But taking the transpose again} followed by \qt{Taking the
  transpose of both sides}). The logic is right; the presentation obscures it.
- The section writes elementary row operations as `R_i + \alpha R_j -> R_i`,
  whereas `gemini.md` and ch. 6 use `E_i`. Here the deviation looks deliberate
  and correct, since `E_{ij}` is already taken by the matrix units of
  `not:matrix_units`, but the inconsistency with ch. 6 should be recorded
  somewhere rather than left to be rediscovered.
- The rest of the file, from Thm. 17.e.3 onwards, has not been read.

## Open questions

- Whether to go on through ch. 18 and the rest, or to loop back to the bases
  chapters (10a, 11), which were the original starting point before the redirect
  to ch. 16.
- `content/18-vs-out-of-old-ones.tex` twice writes \qt{in \cpageref{...}}, which
  prints \qt{in page 123}. Should be \qt{on}. Noticed in passing, not fixed.
- Ch. 17c calls a vector space `P` in Lemma 17.c.2 while `P` is an invertible
  matrix two statements later. Nothing is wrong and it was left alone
  deliberately, but the collision is a trap for the eye and is flagged in that
  file's `ainote`.
