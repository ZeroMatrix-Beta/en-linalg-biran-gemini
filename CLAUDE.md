# Instructions

Make gemini.md your set of instructions.

## `review/verify-against-source` is the live branch, not `main`

Day-to-day work happens on `review/verify-against-source`. `main` is not
abandoned, it is just downstream: it only moves when a tranche of work is
finished and gets fast-forwarded onto it.

That split is easy to miss, and it bites in one specific way: GitHub shows
`main` by default, so **the compiled `en-linalg-2.pdf` visible on the repo page
is `main`'s copy, not the current one.** Once `main` drifts, the published book
silently goes stale even though every commit has been pushed. It reached 161
commits behind that way, with a PDF holding about a third of the book.

So, when a tranche of work is done (and the PDF has been rebuilt and committed):

```bash
git rev-list --left-right --count origin/main...HEAD   # expect 0 on the left
git push origin review/verify-against-source:main
```

- The left-hand count must be `0`. That means `main` is a strict ancestor and
  the push is a genuine fast-forward, losing nothing.
- If it is not `0`, `main` has commits of its own: stop and ask, do not force.
- Ask me before pushing to `main`. It is not covered by the standing
  push-after-commit authorization in the global notes.
- Pushing only moves the remote. Local `main` stays put until
  `git branch -f main origin/main`.

### The PDF is a committed build artefact

`en-linalg-2.pdf` is tracked, so it goes stale whenever sources change without a
rebuild. `make` (or `latexmk`) regenerates it. To check whether the committed
copy actually matches the sources, compare extracted text rather than bytes: a
rebuild always changes the PDF's embedded timestamp and `/ID`, so the file
differs byte-wise even when nothing in the book has. The `pdftotext` on this
machine is Xpdf's, which will not read a PDF from stdin, so both sides need to
be real files:

```bash
git show HEAD:en-linalg-2.pdf > ref.pdf
pdftotext ref.pdf ref.txt && pdftotext en-linalg-2.pdf cur.txt
diff -q ref.txt cur.txt
```
