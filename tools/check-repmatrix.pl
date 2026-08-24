#!/usr/bin/env perl
# Check that adjacent representation matrices in a product compose.
#
# House convention (gemini.md): for T: V -> W with bases B of V and C of W the
# representation matrix is [T]_{C}^{B}, superscript = source, subscript = target.
# The composition rule
#
#     [S o T]_{C}^{A} = [S]_{C}^{B} . [T]_{B}^{A}
#
# therefore forces the *superscript of the left factor* to equal the
# *subscript of the right factor*: the bases meet diagonally. Any product of two
# representation matrices whose inner bases differ is either a typo or a proof
# that does not compose.
#
# Run from the repository root:
#     perl tools/check-repmatrix.pl
#
# Exit status 1 if any mismatch was found.

use strict;
use warnings;

# Read one balanced {...} group starting at index $i. Returns (content, next index).
sub grab_group {
    my ($s, $i) = @_;
    return (undef, $i) unless substr($s, $i, 1) eq '{';
    my $depth = 0;
    my $j     = $i;
    while ($j < length $s) {
        my $c = substr($s, $j, 1);
        if    ($c eq '{') { $depth++ }
        elsif ($c eq '}') {
            $depth--;
            return (substr($s, $i + 1, $j - $i - 1), $j + 1) if $depth == 0;
        }
        $j++;
    }
    return (undef, $i);
}

# Read one [...] group (no nested brackets) starting at index $i.
sub grab_bracket {
    my ($s, $i) = @_;
    return (undef, $i) unless substr($s, $i, 1) eq '[';
    my $j = index($s, ']', $i);
    return (undef, $i) if $j < 0;
    my $body = substr($s, $i + 1, $j - $i - 1);
    return (undef, $i) if $body =~ /[\[\]]/;
    return ($body, $j + 1);
}

my $bad     = 0;
my $checked = 0;
my @unclear;

for my $file (glob 'content/*.tex') {
    open my $fh, '<', $file or die "$file: $!";
    my $text = do { local $/; <$fh> };
    close $fh;

    # Byte offset -> line number.
    my @nl = (0);
    while ($text =~ /\n/g) { push @nl, pos($text) }
    my $lineof = sub {
        my $p  = shift;
        my $lo = 0;
        my $hi = $#nl;
        while ($lo < $hi) {
            my $mid = int(($lo + $hi + 1) / 2);
            if ($nl[$mid] <= $p) { $lo = $mid } else { $hi = $mid - 1 }
        }
        return $lo + 1;
    };

    # Collect every [map]_{sub}^{sup} (or ^{sup}_{sub}) token.
    my @tok;
    my $i = 0;
    while (($i = index($text, '[', $i)) >= 0) {
        my ($map, $p) = grab_bracket($text, $i);
        unless (defined $map) { $i++; next }

        my ($sub, $sup);
        my $q = $p;
        for (1, 2) {
            last unless $q < length $text;
            my $c = substr($text, $q, 1);
            if ($c eq '_' && !defined $sub) {
                my ($g, $n) = grab_group($text, $q + 1);
                last unless defined $g;
                $sub = $g;
                $q   = $n;
            }
            elsif ($c eq '^' && !defined $sup) {
                my ($g, $n) = grab_group($text, $q + 1);
                last unless defined $g;
                $sup = $g;
                $q   = $n;
            }
            else { last }
        }

        if (defined $sub && defined $sup) {
            push @tok, { map => $map, sub => $sub, sup => $sup,
                         start => $i, end => $q, line => $lineof->($i) };
            $i = $q;
        }
        else { $i++ }
    }

    # Adjacent tokens in the source are a product when only multiplication
    # scaffolding separates them.
    for my $k (0 .. $#tok - 1) {
        my ($a, $b) = ($tok[$k], $tok[$k + 1]);
        next if $b->{start} - $a->{end} > 60;
        my $gap = substr($text, $a->{end}, $b->{start} - $a->{end});

        # An \underbrace label sits between the two factors as "}_{...}" and
        # routinely contains "=" or "+", which would otherwise make the pair
        # look unclassifiable. Strip the labels before judging the gap; this is
        # what hid the mismatch in the proof of Corollary 17.b.7.
        $gap =~ s/\}_\{[^{}]*\}//g;

        # Anything that transposes, inverts, adds or ends the formula breaks the
        # adjacency: only a product of the two as written is checkable here.
        next if $gap =~ /(\\transp|\^|\+|=|\\\\|\n\s*\n|\\end|\\begin|\\text|\\quad|,)/;

        my $scaffold = $gap;
        $scaffold =~ s/\\cdot|\\,|\\;|\\!|\\left|\\right|\\big[lr]?|\\underbrace|\\Big[lr]?|[\s(){}]//g;
        if ($scaffold ne '') {
            push @unclear, sprintf("%s:%d  gap %s", $file, $a->{line}, $gap =~ s/\s+/ /gr);
            next;
        }

        $checked++;
        if ($a->{sup} ne $b->{sub}) {
            $bad++;
            printf "MISMATCH  %s:%d\n", $file, $a->{line};
            printf "          [%s]_{%s}^{%s} . [%s]_{%s}^{%s}\n",
                $a->{map}, $a->{sub}, $a->{sup}, $b->{map}, $b->{sub}, $b->{sup};
            printf "          left superscript {%s} must equal right subscript {%s}\n\n",
                $a->{sup}, $b->{sub};
        }
    }
}

printf "checked %d adjacent products, %d mismatch(es)\n", $checked, $bad;
if (@unclear) {
    printf "\n%d pair(s) skipped as unclassifiable, review by eye:\n", scalar @unclear;
    print "  $_\n" for @unclear;
}
exit($bad ? 1 : 0);
