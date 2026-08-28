#!/usr/bin/env perl
# Check that every definition puts something in the index.
#
# The index is built out of \newterm, which marks a term at the place where
# the prose introduces it, and out of \defterm for the cases where no single
# phrase in the sentence is the term (see the preamble of en-linalg-2.tex).
# A definition environment containing neither is a defined term the reader
# cannot look up, and LaTeX reports nothing.
#
# Run from the repository root:
#     perl tools/check-index.pl
#
# Exit status 1 if any definition indexes nothing.

use strict;
use warnings;

# Environments whose whole point is to introduce a term. `notation` is
# deliberately not among them: it introduces a symbol, not a word, and several
# of them ("$A^t$ is also written for the transpose") have nothing a reader
# would look up. Index those where the notation does name something, but do
# not require it.
my @envs = qw(definition definition* aidefinition);
my $envre = join '|', map { quotemeta } @envs;

my $missing = 0;
my $checked = 0;

for my $file (glob 'content/*.tex') {
    open my $fh, '<', $file or die "$file: $!";
    my @lines = <$fh>;
    close $fh;

    for my $i (0 .. $#lines) {
        next unless $lines[$i] =~ /\\begin\{($envre)\}/;
        my $env = $1;

        # Body runs to the matching \end{...} of the same environment.
        my $body  = '';
        my $depth = 0;
        my $j     = $i;
        for (; $j <= $#lines; $j++) {
            $depth++ if $lines[$j] =~ /\\begin\{\Q$env\E\}/;
            $depth-- if $lines[$j] =~ /\\end\{\Q$env\E\}/;
            $body .= $lines[$j];
            last if $depth == 0;
        }

        $checked++;
        next if $body =~ /\\(newterm|defterm|index)\b/;

        # Report the title if the environment carries one, so the entry that
        # needs writing is obvious from the check output alone.
        my ($title) = $lines[$i] =~ /\\begin\{\Q$env\E\}\[([^\]]*)\]/;
        printf "NO INDEX ENTRY  %s:%d  %s%s\n",
            $file, $i + 1, $env, defined $title ? " [$title]" : "";
        $missing++;
    }
}

printf "checked %d definition environments, %d with no index entry\n",
    $checked, $missing;
exit($missing ? 1 : 0);
