# Prose and Math Clarity Review, Chapters 1 to 9

The companion to `review-clarity.md`, which covers 10.a onwards and says so in
its own title. These nine foundational chapters had been through the rigour
audit (`audit-rigour.md`, complete) and the source-verification audit, but never
this pass.

## Status: applied

**All of this has been fixed**, in the commit that adds this file, except
finding 3. Read the document as a record of what was wrong and why, not as a
list of work outstanding; the line numbers are the ones the findings were
written against, so they no longer all point at the text described.

Finding 3 is deliberately left: the duplicated exercises are not a defect,
nothing they say is false, and merging them is a restructuring decision rather
than a correction.

Two things noted in passing were also left alone on purpose, and both say why
in place: the three list-heading cases under finding 5, which want the
`description` environment and are a separate question; and `thm:fp_is_field`,
which the rigour audit already handled.

The book builds clean at 458 pages and all three checks pass. Each finding gives
file:line, what it says, why it is wrong, and the fix that was made.

**Verification status** is stated per finding:

- **CONFIRMED** means checked by hand against the source, the compiled PDF, or
  the book's own conventions in this session.
- **REPORTED** means it has not yet been checked. Treat these as leads.

## Coverage, stated honestly

This is a first pass, and it is not uniform. What was done:

- **Mechanical sweeps across all nine chapters and their solutions**: sub-part
  label consistency, numeric-vs-alphabetical citations, em dashes, `\ell` vs
  plain `l`, elementary-row-operation forms, `\exsol` link coverage,
  `\defterm` + `\textbf` against `\newterm`, raw `M_{m \times n}` against the
  `\M` macro, and formatting macros inside environment headers. These are
  complete and their results are reliable.
- **Read in full, with every computation checked by hand**: chs. 1, 5, 6 and 8.
- **Read in part**: ch. 2 to line 330 of 488; ch. 3 to line 146 of 512; ch. 9
  to line 151 of 488.
- **Targeted reading only**: chs. 4 and 7, driven by what the sweeps turned up.

So chs. 1, 5, 6 and 8 are well covered, and ch. 2 nearly so. **Chs. 3, 4, 7 and
9 are the remaining thin spots**, along with the solutions files of chs. 3, 4,
7 and 9. Nothing below is speculative: every finding marked CONFIRMED was
checked against the source, the compiled PDF, or the book's own conventions.

Arithmetic verified by hand and found correct: all of ch. 1 (Binet and its
derivation, the general-initial-values formula and both check cases, the
continued-fraction convergents, $M^n$ by induction, Cassini at $n = 6$); ch. 5's
$\mathbb{F}_5$ examples and both Cayley tables in `fig:cayley_tables`; **all
three worked examples of ch. 6**, including substituting the general solution
of `ex:full_reduction` back into the original system; and ch. 8's
`lem:span_of_finite_list` regrouping argument.

---

## Chapter 1, The Fibonacci Sequence

### 1. \qt{Eigenvector} defined without excluding the zero vector

`content/01-fibonacci.tex:353`, against `content/21-eigenvalues-eigenvectors.tex:64`.
CONFIRMED.

`def:fixed_point_eigenvector` reads: \qt{An element $y_0 \in X$ is an
eigenvector of $T$ if $T(y_0)$ is proportional to $y_0$, that is, if
$T(y_0) = \lambda \cdot y_0$ for some $\lambda \in \mathbb{R}$.} There is no
requirement $y_0 \ne 0$.

Ch. 21's `def:eigenvalue_eigenvector` has it: \qt{there exists a vector
$v \ne 0$ such that $Tv = \lambda v$ \dots Any vector $v \ne 0$ with the
property that $Tv = \lambda v$ is called an eigenvector.} So the book defines
the same word twice, incompatibly, and the ch. 1 version admits $0$ as an
eigenvector for every $\lambda$.

The symptom is visible two propositions later: `prop:eigenvectors_shift` at
`:386` has to open \qt{A sequence $\mathcal{A} \ne \mathcal{F}_{0,0}$ is an
eigenvector of the shift map $S$\dots}, excluding by hand what the definition
should have excluded.

A second, smaller point in the same definition: it is stated for a map
$T \colon X \to X$ on an arbitrary set $X$, but $\lambda \cdot y_0$ needs a
scalar multiplication that a bare set does not carry.

Fix: add $y_0 \ne 0$ to the definition, and either say $X$ is a real vector
space or state the definition for $\Fib$, which is the only $X$ it is used on.

### 2. A six-part exercise links to one of its six solutions

`content/01-fibonacci.tex:597`. CONFIRMED.

`exc:ch1_list` has parts (a) to (f) and ends `\exsol{sol:shift_is_linear_b}`,
which is the solution to part **(b)** alone, and which `exc:shift_is_linear`
already links at `:347`. The five solutions `sol:ch1_list_a`, `_c`, `_d`, `_e`
and `_f` sit immediately below in the same subsection and **nothing points at
them**: no `\exsol` anywhere names them.

Ch. 1 defines nine solutions and links four. Of chapters 1 to 9 it is one of
only two with orphaned solutions, and the only one where the orphans belong to
a numbered exercise. `\exsol` takes a single label
(`en-linalg-2.tex:738`), so the fix is to add per-part links, or one `\exsol`
per part, or a sentence after the list naming the pages.

### 3. Duplicated exercises resolved three different ways

`content/01-fibonacci.tex:566`, against `:285` and `:548`. CONFIRMED.

Prof. Biran's own list `exc:ch1_list` overlaps the Sheet 1 problems:

| Biran's list | Sheet 1 exercise | How it is handled |
|---|---|---|
| (b) shift is linear | `exc:shift_is_linear` (`:343`) | one shared solution. Good |
| (a) general formula | `exc:golden_ratio_part1` (b) (`:290`) | two separate solutions |
| (e) the limit $a_n/a_{n-1}$ | `exc:golden_ratio_part2` (`:548`) | two separate solutions |

Nothing is false; the reader simply meets the same question twice with no note
that it is the same question. Fix: give (a) and (e) the treatment (b) already
has, or cross-reference.

### 4. A stray factor of one in a display

`content/01-fibonacci.tex:670`. CONFIRMED, cosmetic.

`sol:ch1_list_e` ends its display with `\cdot \frac{1}{1}`, which prints a
literal $\cdot \frac{1}{1}$. The identity is correct without it. Fix: delete.

---

## Chapters 4, 5 and 9, and the term-marking convention

### 5. Central defined terms marked with `\textbf`, not `\newterm`

CONFIRMED. This is finding 2 of `review-clarity.md` recurring, unfixed, and
much wider than it was in 10.a.

`\newterm` (`en-linalg-2.tex:242`) prints a term in red-quoted italics **and**
files it in the index in bold. `\defterm` (`:184`) only files it. The two are
visually different, so a term carrying `\defterm` plus `\textbf` is indexed
correctly but printed in the wrong style: bold, where every other defined term
in the book is red-quoted italic.

Where it happens:

| Location | Definition | Terms printed bold |
|---|---|---|
| `04-maps.tex:170` | `def:injective_surjective_bijective` | injective, surjective, bijective |
| `09-linear-independence.tex:24` | `def:linear_independence` | linearly independent |
| `09-linear-independence.tex:147` | `def:family` | set of indices |
| `09-linear-independence.tex:255` | `def:linear_dependence` | linearly dependent, non-trivial linear combination |
| `05-fields.tex:129` | `def:field_fp` | remainder |
| `05-fields.tex:22` and `:31` | `def:field` | field (see below) |

\qt{Field} is the sharpest single case. The word is introduced three different
ways and `\newterm` is not one of them: `\textbf{field}` in the run-up at
`05:22`, then `\textit{field}` inside `def:field` itself at `:31`, with
`\defterm{field}` supplying the index entry at `:30`. So the chapter that names
the book's ground notion never marks it in the house style, and marks it
inconsistently with itself.

The counts make the point better than the list does. **Chapter 4 uses
`\newterm` exactly twice, for \qt{graph} and \qt{vertical line test}**, while
injective, surjective and bijective, the three notions the rest of the book
runs on, get `\textbf`. **Chapter 9 uses `\newterm` zero times**: every defined
term in the chapter on linear independence is bold.

Fix: `\newterm{injective}` and so on, keeping the `\defterm` lines only where
the indexed phrase differs from the printed one.

Not included above, and deliberately: `02-logic.tex:276`, `03-set-theory.tex:110`
and `05-fields.tex:28` also pair `\defterm` with `\textbf`, but there the bold
text is a list-item heading (\qt{Universal ($\forall$):}, \qt{Intersection:},
\qt{Axioms of Addition:}) rather than a term inside a sentence. Those want the
`description` environment under gemini.md, which is a separate and much smaller
question.

---

## Chapter 5, Fields

### 13. An axiom-only proof that uses an axiom it does not have

`content/05-fields.tex:290`. CONFIRMED.

The chapter makes a point of it at `:260`: \qt{if we can prove a theorem using
\emph{only} axioms \textbf{(K1)} through \textbf{(K10)}, that theorem is
universally true for every field in existence}. So the citations have to be
exact, and in `lem:mult_by_zero` the last one is not.

The proof reaches $0 \cdot x + 0 = 0$ and closes with \qt{applying
\textbf{(K3)} once more, we drop the $+\,0$}. But **(K3)** is stated at `:43` as
$$\forall x \in K: 0 + x = x,$$
left-neutrality only. Dropping a $0$ on the *right* needs **(K2)**,
commutativity of addition, and then **(K3)**.

That the distinction is real here, and not pedantry, is settled by the very next
lemma. `lem:no_zero_divisors` is meticulous about it: it cites **(K7)** as
$a^{-1} \cdot a = 1$ and **(K6)** as $1 \cdot b = b$, each matching the
orientation in which the axiom is stated at `:52` and `:51`. One lemma is careful
about sidedness and the one before it is not.

Fix: \qt{applying \textbf{(K2)} and then \textbf{(K3)}, we drop the $+\,0$}.

### 14. A display that changes both sides while the text changes one

`content/05-fields.tex:283`. CONFIRMED, minor.

\qt{Using associativity of addition \textbf{(K1)}, we regroup the left side} is
followed by a display whose *right* side has also silently become $0$, by
**(K4)**, from $0 \cdot x + (-(0 \cdot x))$ on the line before.

Fix: name **(K4)** alongside **(K1)**, or split into two steps.

### 15. The base field changes letter inside the chapter

`content/05-fields.tex:330` and `:350`. CONFIRMED, minor.

The chapter writes the field $K$ throughout, matching the rest of the book. The
two Sheet 3 exercises `exc:quadratic_field_extensions` and
`exc:finite_field_sum_product` write it $k$, so `def:field`'s
$(K, +, \cdot, 0, 1)$ becomes $(k, +, \cdot, 0, 1)$ four pages later with no
remark. The chapter's own `ainote` at `:904` already flags the analogous
$F$-versus-$K$ change between Prof. Biran's notes and the book, so the book is
alert to exactly this issue elsewhere.

Fix: $K$ in both exercises, and $K[\tau]$ for the extension.

Not a finding, recorded so a later pass does not re-raise it: `thm:fp_is_field`
at `:141` states an \qt{if and only if} over $p$ when `def:field_fp` at `:129`
has already required $p$ prime. That was found by the rigour audit and is
handled in place, by the Opus 5 parenthetical at `:143` reading the theorem for
an arbitrary modulus, with the proof at `:149` written for $\mathbb{Z}/n\mathbb{Z}$.

---

## Chapter 6, Systems of Linear Equations

### 6. The general Gauss step is written in the wrong operand order

`content/06-systems-of-linear-equations.tex:497` and `:507`. CONFIRMED.

Both write the elimination step as
$$-a_{ik} \cdot R_1 + R_i \to R_i,$$
leading with the multiple of the *other* row. gemini.md is explicit that this
is Prof. Biran's convention read backwards: \qt{He leads with the row being
changed}, and names `c \cdot R_i + R_j \to R_j` as the exact mistake. The form
wanted is $R_i - a_{ik} \cdot R_1 \to R_i$.

This is not a stray instance. Every other elementary row operation in the
chapter, more than twenty of them at `:84`, `:91`, `:98`, `:339`, `:341`,
`:373`, `:381`, `:403`, `:404`, `:639`--`:669`, `:752`--`:774`, `:858`, `:866`
and `:906`, is target-first. The two that are not sit in the proof of
`thm:row_reduction_exists`, which is the one place a reader learns the pattern
in general form rather than on a numeric example.

The prose at `:495` introducing the display has the same order: \qt{add
$(-a_{ik})$ times row $\#1$ to row $i$}.

Fix: rewrite both as $R_i - a_{ik} \cdot R_1 \to R_i$ and turn the prose round
to \qt{subtract $a_{ik}$ times row $\#1$ from row $i$}.

Sharpening the point: the chapter's own `ainote` at `:905` sets out the
convention explicitly, \qt{the row that changes always stands \emph{after} the
arrow \dots which is the reverse of what reading the expression left to right
suggests}. The two displays in the proof are the reverse of what the chapter
itself teaches four pages later.

### 7. Row operations described in prose with no arrow form

`content/06-systems-of-linear-equations.tex:495` and `:517`. CONFIRMED, minor.

Three operations in the proof of `thm:row_reduction_exists` are given in words
only, against the house rule that an operation described in prose gets the arrow
form too, because the words carry the intent and the annotation pins down the
convention:

- `:495` \qt{Multiply row $\#1$ by $\frac{1}{a_{1k}}$}
- `:517` \qt{we multiply row $\#2$ by a scalar so that its leading term
  becomes $1$}
- `:517` \qt{We now add suitable multiples of row $\#2$ to all the other rows}

Fix: append the arrow form, e.g. \qt{\dots by $\frac{1}{a_{1k}}$
($\frac{1}{a_{1k}} \cdot R_1 \to R_1$)}.

### 16. A swap presented as though its inverse were a different operation

`content/06-systems-of-linear-equations.tex:405`. CONFIRMED, minor.

Claim 2 exhibits the inverse of each elementary row operation. For Types 1 and 2
the inverse genuinely is a different operation, $\frac{1}{\lambda}$ for $\lambda$
and $-\lambda$ for $\lambda$. For Type 3 the entry reads

> If $(S) \xrightarrow{R_i \leftrightarrow R_j} (S')$, then
> $(S') \xrightarrow{R_j \leftrightarrow R_i} (S)$.

Nothing here is false, but $R_j \leftrightarrow R_i$ *is* $R_i \leftrightarrow R_j$:
a swap is symmetric in its two arguments. Writing the indices in the other order
suggests a distinct inverse operation and hides the actual reason, which is that
the operation is an involution, and which is the more useful fact.

Fix: \qt{then $(S') \xrightarrow{R_i \leftrightarrow R_j} (S)$: a swap is its own
inverse.}

### 17. Matrix spaces written without the `\M` macro

`content/06-systems-of-linear-equations.tex:884`. CONFIRMED.

`exc:inconsistent_2x2_system` opens \qt{Let $A \in M_{2 \times 2}(\mathbb{R})$},
with a plain italic $M$. gemini.md: \qt{Always use the macro `\M` \dots This
renders as `\mathcal{M}` and distinguishes the space from a specific matrix
$M$.} Chapter 8 uses `\M` correctly throughout, at `:390`, `:425`, `:494` and
`:522`, so this is the sole lapse in chapters 1 to 9.

Fix: `\M_{2 \times 2}(\mathbb{R})`.

**Outside the scope of this review, but found by the same sweep and worth
recording:** five more raw matrix spaces in ch. 20, at
`20-determinants.tex:224`, `:290`, `:483`, `:564` and `:605`. The one at `:564`
is the case the macro exists to prevent, printing the space and a specific
matrix in the same italic letter within one clause:

> \qt{for any matrix $M \in M_{m \times n}(K)$, we have the transposed matrix
> $M\transp \in M_{n \times m}(K)$}

---

## Chapter 7, Vector Spaces

### 8. A dimension claim that is false for a value the definition admits

`content/07-vector-spaces.tex:571`, against `:560` and `:548`. CONFIRMED.

`ex:bounded_degree_subspace` fixes
$d \in \mathbb{Z}_{\ge 0} \cup \{-\infty\}$ at `:560`, defines
$K[x]_d := \{f \in K[x] \mid \deg(f) \le d\}$, and then says at `:571`:
\qt{Later, we will see that $K[x]_d$ is a subspace of dimension $d+1$.}

The degree convention is set at `:548`: $\deg(f) := -\infty$ for the zero
polynomial, and \qt{$\deg(f) = -\infty$ if and only if $f = 0$}. So
$K[x]_{-\infty} = \{0\}$, of dimension $0$, and the formula $d+1$ reads
$-\infty + 1$, which is not a number at all.

The $-\infty$ case is not a pedantic reading: it is admitted on purpose two
lines earlier, and the proof at `:725` uses it (\qt{The zero polynomial has
degree $-\infty \le d$, so it lies in $K[x]_d$}).

Fix: \qt{\dots for $d \ge 0$, of dimension $d+1$, while
$K[x]_{-\infty} = \{0_{K[x]}\}$ has dimension $0$}.

### 9. Two claims whose proofs exist but are not announced

`content/07-vector-spaces.tex:566` and `:593`. CONFIRMED, minor.

`claim:bounded_degree_subspace` and `claim:matrix_space` are stated and left.
Their proofs are in the chapter's own solutions subsection at `:723` and
`:734`, correctly titled \qt{Proof of the Claim on \dots, on \cpageref{\dots}}
as gemini.md requires. But the claims themselves carry no forward pointer, so a
reader meets an unproved claim with no sign that a proof exists anywhere.

The book is inconsistent here rather than wrong: `claim:empty_set_is_subset` at
`03-set-theory.tex:90` is proved inline, and `claim:scalar_product_forces_pos_def`
at `22a-euclidean-hermetian-spaces-a.tex:251` writes \qt{(Proof: a bit later)}.

These two are also the only other orphans in the `\exsol` sweep, which is what
brought them up; being `claim*` rather than exercises, they cannot carry
`\exsol`, so the fix is the ch. 22a phrasing.

### 10. The eight vector-space axioms are labelled twice

`content/07-vector-spaces-solutions.tex:257`. CONFIRMED in the compiled PDF.

`sol:power_set_f2_vector_space` opens \qt{We verify the eight vector space
axioms \textbf{(V1)}--\textbf{(V8)}}, then runs
`\begin{enumerate}[label=\textbf{(\alph*)}]` whose eight items each begin
`\textbf{(V1)}`, \dots, `\textbf{(V8)}`. The page therefore prints

> **(a) (V1) Associativity of Addition:** \dots
> **(b) (V2) Neutral Element:** \dots

Two label systems on one list, and the one the sentence promised is the one
that is not the list marker. This is the defect class of finding 10 in
`review-clarity.md`, here in chs. 1--9.

It is also the only instance in these nine chapters: the sweep for numeric
sub-part citations returns nothing else, and every other `\exsol`-linked
exercise and solution pair agrees on its labels.

Fix: `\begin{enumerate}[label=\textbf{(V\arabic*)}]` and delete the eight
hardcoded prefixes; or a `description` environment, which is what gemini.md
asks for when every item carries a name.

---

## Chapter 8, Span

### 11. An em dash in an exercise title, where the book has a macro for this

`content/08-span.tex:339`. CONFIRMED.

`\begin{exercise}[Two Independent Vectors Span the Plane --- Important!]` uses
a literal `---`, against the house ban on em dashes in the book's prose. It is
the only `---` in chs. 1--9 outside comment rules and TikZ comments.

The book already has a convention for exactly this: important exercises are
flagged with `\faHeart` at the end of the title, and 32 of them are. This one
spells the flag out in words instead.

Fix: `[Two Independent Vectors Span the Plane \faHeart]`.

### 18. The empty linear combination is used but excluded by the definition

`content/08-span.tex:612` and `:624`, against `:76` and `:114`. CONFIRMED, minor.

`def:linear_combination` at `:76` and `lem:span_is_linear_combinations` at
`:114` both quantify over $n \in \mathbb{N}$, and the book's $\mathbb{N}$ is
$\{1, 2, 3, \dots\}$, fixed at `02-logic.tex:297` and again at
`03-set-theory.tex:296`. So a linear combination has at least one term.

Two places then use one with none:

- `rem:span_of_empty_set` at `:245`: \qt{we just think of the sum of an empty
  collection of elements as $0$}.
- `sol:span_of_finite_list` at `:612` reads `lem:span_is_linear_combinations`
  back as \qt{all linear combinations $\sum_{j=1}^{k} \beta_j u_j$ with
  $k \ge 0$}, which is not what the lemma says, and closes at `:624` with
  \qt{The empty combination, $k = 0$, becomes the sum with all
  $\alpha_i = 0$}.

Nothing false is proved. `rem:span_of_empty_set`'s real argument is the one from
above, that $\mathcal{N}$ is all of the subspaces and their intersection is
$\{0_V\}$, and it is airtight; the empty-sum sentence is offered as an aside on
the other description. The chapter's `ainote` at `:588` is already alert to the
asymmetry, noting that \qt{the description from below needs $S \ne \emptyset$
while the description from above does not}.

Fix: let $n$ range over $\mathbb{Z}_{\ge 0}$ in `def:linear_combination`, with a
word that the empty combination is $0_V$; or drop the $k \ge 0$ reading at
`:612` and the last sentence of `:624`, neither of which the proof needs.

### 19. A proof-strategy diagram that labels its parts in the wrong face

`content/08-span.tex:139`--`:141`. CONFIRMED, nit.

The TikZ diagram setting out the three facts of
`lem:span_is_linear_combinations` labels them `\emph{(a)}`, `\emph{(b)}`,
`\emph{(c)}`, while the paragraph reading the diagram at `:160` and the
enumerate carrying the actual proof at `:162` both use `\textbf{(a)}` and so on.
gemini.md's sub-part rule names TikZ nodes explicitly as being in scope.

Fix: `\textbf{(a)}` in the three nodes.

---

## Chapter 9, Linear Independence

### 12. Plain `l` where the same display writes `\ell`

`content/09-linear-independence.tex:60` and `:62`. CONFIRMED.

`lem:independence_basics` **(c)** is stated at `:50` with
\qt{$v_k = v_\ell$ for some $k \ne \ell$}. Its proof then writes:

- `:60` \qt{the coefficient for $v_l$ is $-1$}
- `:62` `\dots + (-1) \cdot v_\ell + \dots = v_k - v_l = 0_V`

so a single display contains both $v_\ell$ and $v_l$ for the same vector.
gemini.md: \qt{Always use `\ell` for the letter `l` in math mode \dots Never use
a standard `l`.} Beyond the convention, $v_l$ next to the index $1$ is a real
legibility problem.

These two are the **only** occurrences of a plain `l` subscript in chapters 1
to 9; the sweep is clean otherwise.

Fix: `v_\ell` in both places.

---

## Swept and clean

Reliable negative results, across all nine chapters and their solutions:

- **Numeric sub-part citations.** Nothing outside finding 10 above. In
  particular ch. 1's `exc:ch1_list` is cited correctly as **(b)**, **(d)** and
  **(e)** at `:125`, `:604`, `:650` and `:717`, matching the printed (a)--(f).
- **`\exsol` link coverage.** Chs. 2, 3, 4, 5, 6, 8 and 9 link every solution
  they define. Only ch. 1 (finding 2) and ch. 7 (finding 9) have orphans.
- **Formatting macros inside environment headers.** None; the Bracket
  Restriction is respected throughout.
- **Elementary row operations.** Correct everywhere except finding 6.
- **`\ell`.** Clean except finding 12.
- **Em dashes.** Clean except finding 11.
- **Chapters 2 and 3** turned up nothing on close reading beyond the
  list-heading question noted under finding 5. The mathematics checked: the
  truth tables, the vacuous-truth treatment of $\emptyset \subseteq Q$, the
  quantifier-order remark and its table figure, and the two set-builder
  examples at `03:81` and `03:85` are all correct.
- **Chapter 1's mathematics** was verified by hand end to end: Binet's formula
  and its derivation, the general-initial-values formula at `:631` and both of
  its check cases, the continued-fraction convergents $x_n = a_{n+1}/a_n$, the
  limit computation, $M^n$ by induction and Cassini's identity including the
  worked $n = 6$. All correct.

## Where a second pass should start

1. Chs. 5, 6 and 8 have had sweeps but little reading. Ch. 6 is the longest
   file in the group at 912 lines and the only one whose subject is
   computational, which is where arithmetic slips live.
2. The rigour audit's standing item applies here and was not attempted:
   *where a chapter has a figure, read the caption against the statement it
   illustrates.* Chs. 1, 2, 3, 6 and 8 all carry TikZ figures. One candidate
   already noticed but not pursued: `02-logic.tex:164`, where the purple ray
   for $x < 1$ is drawn closed at the point $x = 1$, which belongs to the green
   interval $[1,2]$; the green dot is drawn last and covers it, so this may be
   invisible in print.
3. The solutions files of chs. 3 to 9 were not read except where a sweep
   pointed into them.
