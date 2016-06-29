package String::Normal::Config::AddressStop;
use strict;
use warnings;

use String::Normal::Config;

sub _data {
    my %params = @_;

    my $fh;
    if ($params{addres_stop}) {
        open $fh, $params{addres_stop} or die "Can't read '$params{addres_stop}' $!\n";
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

This package defines removals to be performed on address types.

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
