# Prose and Math Clarity Review, Chapters 10.a onwards

Read-only review. Nothing here has been applied except the two items in 10.a
marked DONE. Each finding gives file:line, what it says, why it is wrong, and
the minimal fix.

**Verification status** is stated per finding:

- **CONFIRMED** means checked by hand against the source in this session.
- **REPORTED** means a review agent found it and it has not yet been checked.
  Treat these as leads, not facts, until confirmed.

---

## Chapter 10.a, Bases (Part A)

### 1. Lemma B' said "the" drop index where Lemma B gives only existence. DONE

`content/10a-bases-part-a.tex:226`. CONFIRMED, fixed in commit `347f21a`.

Lemma B' opened "let $j$ be the index it provides", but Lemma B
(`lem:targeted_redundancy`) is an existence statement and several indices can
satisfy it; only its proof singles one out, as the largest index with
$a_j \ne 0$ for one chosen dependency relation.

The lemma is true for any such $j$, since its proof uses only the property
$v_j \in \Sp(v_1,\dots,v_{j-1})$. Chapter 11 already spells this out at
`content/11-bases-part-b.tex:98`; 10.a now agrees with it.

### 2. Defined terms marked with `\textbf`, the aside with `\newterm`. DONE

`content/10a-bases-part-a.tex:15` and `:46`. CONFIRMED, fixed in `347f21a`.

Backwards under gemini.md, and it meant the index entry for "basis" was
generated from the parenthetical plural rather than from the definition.

## Chapter 11, Bases (Part B)

Clean. The Steinitz applications in Statements 2 and 3, the empty-basis
argument for $\dim\{0_V\} = 0$, and the infinite-$S$ caveat on
$\dim K^S = |S|$ all check out. The "select $n+100$ vectors" flourish at
`11:167` is unusual but valid.

---

## Chapters 12 to 16

### 3. Exercise and its own solution describe different maps

`content/15a-linear-maps.tex:117`. CONFIRMED.

The exercise defines
`T(p) := (3p(4) + 5p^3(6) + b p(1)p(2), ...)`, and asks to show $T$ is linear
iff $b = c = 0$. The solution at `content/15a-linear-maps-solutions.tex:60`
silently works with `3p(4) + 5p(6)`, dropping the exponent.

`p^3(6)` has no fixed meaning. Read as a cube, which is how the same display
writes the square `c (p(0))^2`, the first component is nonlinear for every $b$
and the claim is false as written.

Fix: write the third derivative explicitly, `5p^{(3)}(6)`, and restore that
term in the solution's $T_1$; or drop the exponent in the statement.

### 4. Bases written as sets in an exercise whose answers depend on order

`content/16-linear-maps-and-bases.tex:213-216`. CONFIRMED.

`content/16-linear-maps-and-bases.tex:21` fixes the convention: "We will write
bases of a vector space $V$ as an ordered list (or tuple)". The exercise then
writes $\mathcal{A} = \{e_2, e_1\}$, $\mathcal{B} = \{e_2, -e_1\}$ and so on
with set braces, but every answer depends on the order. As a set,
$\{e_2,e_1\}$ is the standard basis, under which $f$ has matrix
$\operatorname{diag}(-1,1) \ne M$, so item (d) is false under the printed
notation and true only under the ordered reading. Item (b) likewise flips.

Fix: use tuples throughout, $(e_1,e_2)$, $(e_2,-e_1)$, $(-e_2,e_1)$, $(e_2,e_1)$.

### 5. `$w'_j$` means a column in one proof and a row eighteen lines later

`content/13-row-and-col-space.tex:267`, with `:249`. REPORTED.

`def:matrix_subspaces` reserves $u$ for rows and $v$ for columns. The same
letter is also used for rows at `:136` and for columns at `:168`, where
`$\sum \alpha_i w_i = 0 \iff \sum \alpha_i w'_i = 0$` never says what $w_i$ is.

Fix: write the rows of $B$ as $u'_1,\dots,u'_r$ in `thm:row_basis`, and say in
the important remark that $w_i, w'_i$ denote columns of $A$ and $A'$.

### 6. `$\oplus$` used about 100 pages before it is defined

`content/15a-linear-maps.tex:698-699`. REPORTED.

$\oplus$ and "direct sum" are first defined at
`content/18-vs-out-of-old-ones.tex:571`. Chapter 14 introduces the notion under
the name *complement* (`def:complement`) and never the symbol.

Fix: parenthetical at first use, naming `\cref{def:complement}`.

### 7. Sentence names the wrong path through the commuting square

`content/16-linear-maps-and-bases.tex:315`. CONFIRMED.

"Going down first and then across is the composition defining $T_A$." Down then
across is $T_A \circ \Phi_{\mathcal{B}}$; the composition defining $T_A$ is
$\Phi_{\mathcal{C}} \circ T \circ \Phi_{\mathcal{B}}^{-1}$, which is what the
display immediately below correctly uses.

Fix: "The bottom arrow is by definition the composition
$\Phi_{\mathcal{C}} \circ T \circ \Phi_{\mathcal{B}}^{-1}$, so".

---

## Chapters 17 to 19

The review agent hand-verified every representation-matrix pair in 17.b and 18,
including the six that `tools/check-repmatrix.pl` skips, and found the index
conventions correct throughout.

### 8. $T$ is never quantified in an exercise

`content/17b-matrices_b_change_of_basis.tex:114`. REPORTED.

$T$ first appears inside the formula $A = [T]_{\mathcal{C}}^{\mathcal{B}}$ with
no "a linear map $T$" in the existential list. Part (d) of the same exercise
does it correctly, and the solution at `17b:291` supplies $T := T_A$.

Fix: add "a linear map $T \colon V \to W$," after "$\dim W = m$,".

### 9. A bare `\begin{proof}` detached from its proposition

`content/17a-matrices_a_matrix_multiplication.tex:261`. REPORTED.

It proves `prop:matrix_multiplication_properties` at `:196`, but three exercise
environments stand between them, so the reader meets an unlabelled "Proof."
after an exercise. The book handles this correctly at `17e:148`.

Fix: `\begin{proof}[Proof of \cref{prop:matrix_multiplication_properties}]`.

### 10. Sub-parts cited as (1), (2), (3) where the list prints (a), (b), (c)

REPORTED. `en-linalg-2.tex:376` sets `label=(\alph*), ref=(\alph*)`.

Instances given: `17b-...-solutions.tex:43,53,55,78-85`;
`17c-...-solutions.tex:51,63,64,79,84`; `18-...-solutions.tex:63-74`.
Worst case claimed: `17c-...-solutions.tex:63` cites
`\cref{rem:rank_notation_and_properties} \textbf{(2)}` where the printed label
is **(b)**. `17a-...-solutions.tex:80` gets it right, showing the convention.

### 11. $B$ is both the Borel subgroup and a single matrix

`content/17e-...-solutions.tex:168` and `:178`. REPORTED.

Produces "$B := U^{-1} \in B$". The exercise statement at `17e:324` fixes
$B, B'$ as matrix names, so the group is what should be renamed.

Fix: call the subgroup $\mathcal{B}$ or $\mathcal{U}$ throughout the solution.

### 12. $E_{pq}$ called an "elementary matrix"

`content/18-...-solutions.tex:91`. REPORTED.

"Elementary matrix" is defined in 17.e as $Q_{ij}(\alpha)$, $P_{ij}$,
$S_i(\alpha)$. $E_{pq}$ is the matrix unit of `not:matrix_units` and is not
invertible, so it is not an elementary matrix under the book's own definition.

Fix: "the matrix unit $E_{pq}$ (\cref{not:matrix_units})".

---

## Chapters 20 and 21

### 13. Wrong characteristic polynomial in an exercise hint

`content/21-eigenvalues-eigenvectors.tex:1155`. CONFIRMED, and the most serious
finding in this review.

For $A = \begin{pmatrix}1&2&3\\2&3&1\\3&1&2\end{pmatrix}$ the hint states
$P_A(x) = -x^3 + 6x^2 + 9x + 18$ and concludes
$A^{-1} = \frac{1}{18}(A^2 - 6A - 9I_3)$.

Checked by hand: $\det A = -18$, so the constant term is $-18$, not $+18$; the
sum of principal $2\times2$ minors is $-1-7+5 = -3$, so the $x$ coefficient is
$+3$, not $+9$. The correct polynomial is
$$P_A(x) = -x^3 + 6x^2 + 3x - 18,$$
giving $A^{-1} = \frac{1}{18}(-A^2 + 6A + 3I_3)$ and
$p(x) = \frac{1}{18}(-x^2 + 6x + 3)$. Eigenvalues are $6, \pm\sqrt{3}$.

### 14. Quotient-class brackets mixed with coordinate brackets

`content/21-eigenvalues-eigenvectors.tex:969` and `:971`. REPORTED.

$[\,\cdot\,]$ is the class in $V/U$ (fixed at `:926`) while
$[\,\cdot\,]_{\mathcal{C}}$ is the coordinate column. At `:969` the left side is
a coordinate column and the right side a vector of $V/U$; at `:971`
$\overline{T}$ is applied to $v_i \in V$, outside its domain.

Fix: `:969` as $\overline{T} z_i = \alpha_{2i}z_2 + \dots + \lambda_i z_i$;
`:971` as $[T v_i] = \overline{T}[v_i] = \alpha_{2i}[v_2] + \dots + \lambda_i[v_i]$.

### 15. Row-operation case assumption inverted relative to its display

`content/20-determinants.tex:623`, with `:629`. CONFIRMED.

Text says "Assume $j < i$", but the display writes
$\det(\alpha_1,\dots,\alpha_i + c\alpha_j,\dots,\alpha_j,\dots,\alpha_n)$,
putting the modified row before $\alpha_j$, which depicts $i < j$. The case
deferred as "similar" at `:629` is precisely the one written out.

Fix: "Assume $i < j$" and "If $j < i$, the proof is similar."

### 16. Missing backslash on `lambda_1`

`content/21-eigenvalues-eigenvectors.tex:1195`. REPORTED, NOT CONFIRMED.

Claimed to read `P_A(lambda_1)`, which would typeset as italic letters in the
key step of the Cayley-Hamilton proof for diagonalizable matrices. A first grep
did not reproduce it; re-check before acting.

### 17. Em dash in the parity-of-transpositions lemma

`content/20-determinants.tex:355`. REPORTED, NOT CONFIRMED.

Claimed to be a literal U+2014, against the house ban. A first grep did not
reproduce it; re-check before acting.

---

## Chapters 22 to 26

The review agent checked the conjugation convention end to end (linear in the
first slot, conjugate-linear in the second) and found it applied consistently
through Gram-Schmidt, Cauchy-Schwarz, Riesz, the adjoint matrix and the SVD.
The five representation-matrix pairs the checker skips (24:212, 24:234, 25:140,
25:150, 25:523) are correct.

### 23. A matrix called unitary that is not

`content/22b-euclidean-hermetian-spaces-b.tex:343`, matrix at `:336`. REPORTED.

Claims $A_3 = \frac{1}{\sqrt5}\begin{pmatrix} i & -2 \\ 2 & i\end{pmatrix}$ is
unitary. Its columns are not orthogonal:
$\langle c_1,c_2\rangle = \frac15(i\overline{(-2)} + 2\overline{i}) = -\frac{4i}{5}$,
and $\det A_3 = 3/5$. It is skew-Hermitian, but that does not give unitary.

Fix: the intended matrix is almost certainly
$\frac{1}{\sqrt5}\begin{pmatrix} i & -2 \\ 2 & -i\end{pmatrix}$, whose columns
are orthonormal with $\det = 1$ and which is still skew-Hermitian. Change the
$(2,2)$ entry at `:336`, or drop the "unitary" claim.

### 24. A false "if and only if" in a hint

`content/24-spectral-thoerem.tex:324`. REPORTED.

Says $[T^*]_{\mathcal{B}}^{\mathcal{B}} = ([T]_{\mathcal{B}}^{\mathcal{B}})^*$
holds "if and only if" $\mathcal{B}$ is orthonormal. Neither cited result says
that, and it is false: for $T = \id_V$ the identity holds in every basis.
Orthonormality is a hypothesis of `prop:matrix_representation_adjoint`, not an
equivalent condition. The hint's actual point survives.

Fix: "holds whenever $\mathcal{B}$ is orthonormal; orthonormality is a
hypothesis of the proposition, not a consequence, so the identity is not
available here".

### 25. QR proof locates the triangular block in the wrong columns

`content/22b-euclidean-hermetian-spaces-b.tex:446`, against `:421`. REPORTED.

The theorem displays $R = \begin{pmatrix} C & * \\ 0 & 0\end{pmatrix}$ with $C$
the *leading* $r \times r$ block, but the proof puts $C$ in columns
$i_1,\dots,i_r$, which differ whenever $i_1,\dots,i_r \ne 1,\dots,r$, e.g.
$A = \begin{pmatrix}0&1\\0&0\end{pmatrix}$ where $i_1 = 2$. The displayed form
is true, by a shorter route.

Fix: observe instead that $R_{ij} = \langle v_j, e_i\rangle = 0$ for
$i > k(j)$ with $k(j) \le j$, so $R$ is upper triangular as a whole; its
leading $r \times r$ block is then $C$ and the last $n-r$ rows vanish.

### 26. Conclusion not well formed without "symmetric"

`content/22a-euclidean-hermetian-spaces-a.tex:251`. REPORTED.

"If $\langle\cdot,\cdot\rangle_A$ is a scalar product, then $A$ is positive
definite." But `def:positive_definite_matrix_real` at `:239` confers that term
only on a *symmetric* matrix. The complex counterpart at `:291` is explicitly
careful about this, and `exc:real_case_of_claim` and its solution both state it
as "symmetric and positive definite".

Fix: "then $A$ is symmetric and positive definite".

### 27. Generalized-eigenspace symbol used where the eigenspace is meant

`content/23a-dual-spaces-inner-products-a.tex:304`,
`content/24-spectral-thoerem.tex:257`, and
`content/24-spectral-thoerem-solutions.tex:38`. REPORTED.

`\gEig` renders as $\widetilde{\Eig}$ and is defined only in ch. 28.b
(`28b-jordan-b.tex:30`); the eigenspace is $\Eig$ from `def:eigenspace` in
ch. 21, which is what ch. 25 uses. The two coincide for the normal and
self-adjoint operators at hand, so nothing said is false, but the reader meets
an undefined symbol five chapters early, and "geometric multiplicity" is
$\dim \Eig$, never $\dim \widetilde{\Eig}$.

Fix: write `\Eig` in all three places.

---

## Chapters 27 to 28.b

### 18. Isotropic-subspace characterisation is false, real case

`content/27-bilinear-and-quadratic-forms.tex:199`. REPORTED, with a
counterexample worth checking first.

Sylvester's law states
$n - (k+\ell) = \max\{\dim Z \mid B|_{Z \times Z} \equiv 0\}$.

Claimed counterexample: $V = \mathbb{R}^2$, $B = \operatorname{diag}(1,-1)$, so
$k = \ell = 1$ and $n - (k+\ell) = 0$; but $Z := \Sp((1,1))$ has $B(z,z) = 0$,
so the maximum is at least 1. The maximal totally isotropic dimension is
$n-(k+\ell)+\min(k,\ell)$; $n-(k+\ell)$ is the dimension of the radical.

Fix: require $B(z,v) = 0$ for all $z \in Z$ and all $v \in V$.

### 19. Same error in the complex theorem

`content/27-bilinear-and-quadratic-forms.tex:415`. REPORTED.

Claimed counterexample: $B = I_2$ on $\mathbb{C}^2$ gives $r = 2$, $n - r = 0$,
but $W := \Sp((1,i))$ has $B(w,w) = 1 + i^2 = 0$. True maximum over
$\mathbb{C}$ is $n - r + \lfloor r/2 \rfloor$. Same fix.

### 20. Index error in a transcribed hint

`content/28b-jordan-b.tex:535`. REPORTED.

Hint reads $e_{k+j} = f_{k+j} + (\text{something from } W)$. The correct
relation is $e_{k+j} = f_j + w_j$ with $w_j \in W$; $f$ is only indexed
$1,\dots,\ell$, so $f_{k+j}$ may not exist. The chapter's own solution states
it correctly at `:715`.

### 21. Exponent stronger than what has been proved at that point

`content/28b-jordan-b.tex:165`. REPORTED.

Writes $P_{T_\lambda}(x) = (\lambda - x)^{m_a(\lambda)}$, but the lemma two
paragraphs earlier gives only $(\lambda-x)^m$ with $m \le m_a(\lambda)$;
equality needs `cor:nilpotency_on_generalized_eigenspace`, which depends on this
lemma. The argument only needs coprimality, so nothing downstream breaks.

Fix: write the exponents as $m$ and $m'$.

### 22. Ambiguous inertia triple

`content/27-bilinear-and-quadratic-forms.tex:208`. REPORTED.

Immediately after the nullity is defined as $n-(k+\ell)$, the text says "type
$(k, \ell, 0)$", which reads as (positive index, negative index, nullity) and
so implies nullity $0$, true only for non-degenerate $B$.

Fix: write "type $(k, \ell, n - (k+\ell))$".
