#!/usr/bin/env bash
# Run every source invariant check in tools/, report a summary, and exit
# non-zero if any of them failed.
#
# The checks read en-linalg-2.aux, so run pdflatex (or latexmk) first.
#
#     bash tools/check.sh          # from anywhere; it finds the repo root
set -u

cd "$(dirname "$0")/.." || exit 1

fail=0
failed=""

run() {
  local name=$1
  shift
  printf '\n=== %s ===\n' "$name"
  if "$@"; then
    return 0
  fi
  fail=1
  failed="$failed
  - $name"
}

run "cref targets resolve to numbered environments" \
    bash tools/check-crefs.sh
run "adjacent representation matrices compose" \
    perl tools/check-repmatrix.pl

echo
if [ "$fail" -eq 0 ]; then
  echo "All checks passed."
else
  echo "FAILED:$failed"
fi
exit $fail
