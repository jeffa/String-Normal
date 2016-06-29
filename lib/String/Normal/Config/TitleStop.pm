package String::Normal::Config::TitleStop;
use strict;
use warnings;

use String::Normal::Config;

sub _data {
    my %params = @_;

    my $fh;
    if ($params{title_stop}) {
        open $fh, $params{title_stop} or die "Can't read '$params{title_stop}' $!\n";
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

String::Normal::Config::TitleStop;

=head1 DESCRIPTION

This package defines removals to be performed on title types.

=cut

1;
__DATA__
480p
720p
1080p
mp4
avi
mkv
srt
idx
sub
pt1
pt2
cd1
cd2
a
an
and
the
