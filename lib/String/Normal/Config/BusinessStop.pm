package String::Normal::Config::BusinessStop;
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

String::Normal::Config::BusinessStop;

=head1 DESCRIPTION

This package defines removals to be performed on the business types.

=cut

1;
__DATA__
an
and
by
co
cpa
ctr
da
dd
de
dept
dmd
dpm
du
dvm
from
for
grp
in
inc
inst
le
llc
of
pa
pllc
svc
the
to
assn$
assoc$
pc$
unltd$
ltd,3
acctnt$,3 
agci$,3
coop,3
corp$,3
dc
^el
entrprs,3
etc$,3
hq$,3
ind$,3
intl$,3
^mr
