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
   - the statement stands *somewhere* in the notes, only without an
     environment (running prose, a \qt{Notation} heading, inside a Remark)
     $\Rightarrow$ unnumbered `definition*` / `proposition*` / `lemma*`, cited
     with `\cpageref`;
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
| 10a, 11 | the bases chapters | not started; these were the original starting point before the redirect to ch. 16 |
| 19 onwards | | not started |

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

- **Where next.** The user chose ch. 18 over looping back to the bases
  chapters, so the live choice is now ch. 19 onwards versus 10a and 11, which
  were the original starting point before the redirect to ch. 16.
- `\qt{in \cpageref{...}}` prints \qt{in page 123}; it should be \qt{on}. The
  occurrence in ch. 18 is fixed. **Two remain**, in
  `content/10a-bases-part-a.tex:295` and `content/19-misc.tex:196`, both in
  chapters the pass has not reached. Fix them when it gets there, or sweep with
  `\bqt{in \\cpageref}` through the Grep tool (not through Bash, see the trap
  above).
- Ch. 17c calls a vector space `P` in Lemma 17.c.2 while `P` is an invertible
  matrix two statements later. Nothing is wrong and it was left alone
  deliberately, but the collision is a trap for the eye and is flagged in that
  file's `ainote`.
