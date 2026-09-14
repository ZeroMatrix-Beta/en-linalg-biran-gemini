# Instructions

Make gemini.md your set of instructions.

## `main` is the only branch

All work lands on `main` directly. There was once a `review/verify-against-source`
branch holding the live work while `main` sat downstream, but the two were
fast-forwarded together on 2026-09-14 and the review branch was deleted. Nothing
is downstream of anything any more.

Why that arrangement is still worth knowing about: GitHub shows `main` by
default, so **the compiled `en-linalg-2.pdf` visible on the repo page is whatever
`main` points at.** While the branches were separate, `main` drifted 161 commits
behind and the published book sat at about a third of its length, even though
every commit had been pushed. The branch that caused that is gone, but the
exposure is not -- it now arrives by a different road, committing source changes
without rebuilding the PDF. The repo page is only ever as current as the last
committed build.

- Ask me before pushing. It is not covered by the standing push-after-commit
  authorization in the global notes.
- Pushes to `main` should be fast-forwards. If one is rejected as
  non-fast-forward, the remote has moved: stop and ask, do not force.

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
