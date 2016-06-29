package String::Normal::Config::TitleStem;
use strict;
use warnings;

use String::Normal::Config;

sub _data {
    my %params = @_;

    my $fh;
    if ($params{title_stem}) {
        open $fh, $params{title_stem} or die "Can't read '$params{title_stem}' $!\n";
    } else {
        $fh = *DATA;
    }

    my %stem = String::Normal::Config::_slurp( $fh );
    return \%stem;
}

=head1 NAME

String::Normal::Config::TitleStem;

=head1 DESCRIPTION

This package defines substitutions to be performed on title types.

=cut

1;
__DATA__
ii 2
iii 3
iv 4
v 5
vi 6
vii 7
viii 8
ix 9
tenth 10th
eleventh 11th
twelfth 12th
thirteenth 13th
fourteenth 14th
fifteenth 15th
sixteenth 16th
seventeenth 17th
eighteenth 18th
nineteenth 19th
first 1st
twentieth 20th
second 2nd
thirtieth 30th
third 3rd
fortieth 40th
fourth 4th
fiftieth 50th
fifth 5th
sixtieth 60th
sixth 6th
seventh 7th
eighth 8th
ninth 9th
