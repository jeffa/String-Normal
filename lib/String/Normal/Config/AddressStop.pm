package String::Normal::Config::AddressStop;
use strict;
use warnings;

use String::Normal::Config;

sub _data {
    my $file = shift;

    my $fh;
    if ($file) {
        open $fh, $file or die "Can't read $file: $!\n";
    } else {
        $fh = *DATA;
    }

    my %stop;
    for (String::Normal::Config::_slurp( $fh )) {
        next if /^#/;
        my ($word,$count) = split ',', $_;
        $count ||= 1;

        if (substr( $word, 0, 1 ) eq '^') {
            substr( $word, 0, 1 ) = '';
            $stop{first}->{$word} = $count;
        } elsif (substr( $word, -1, 1 ) eq '$') {
            substr( $word, -1, 1 ) = '';
            $stop{last}->{$word} = $count;
        } else {
            $stop{middle}->{$word} = $count;
        }
    }

    return \%stop;
}
=head1 NAME

String::Normal::Config::AddressStop;

=head1 DESCRIPTION

This package defines substitutions to be performed on the name types.

=cut

1;
__DATA__
#ave
#blvd
#cir
#ct
ctr
cv
#dr
e
expy
fwy
hwy
#ln
loop
n
ne
nw
pike
pkwy
pl
plz
pt
#rd
s
se
sq
#st
sw
ter
trl
vlg
w
walk
way
xing