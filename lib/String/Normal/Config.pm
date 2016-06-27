package String::Normal::Config;
use strict;
use warnings;

use String::Normal::Config::NameStem;
use String::Normal::Config::NameStop;
use String::Normal::Config::NameCompress;
use String::Normal::Config::AddressStem;
use String::Normal::Config::AddressStop;
use String::Normal::Config::States;
use String::Normal::Config::AreaCodes;

sub _slurp {
    my $fh   = shift;
    my @data = ();
    chomp( @data = map { $_ || () } map { split /\s+/, $_, 2 } <$fh> );
    close $fh;
    return @data;
}

sub _expand_ranges {
    my @expanded = ();

    for my $line (@_) {
        my @ranges = map { /(\w)-?(\w)/;[$1..$2] } $line =~ /\[(\w-?\w)+\]/g;
        $line =~ s/\[.*//;
        _expand( \my @results, $line, @ranges );
        push @expanded, @results;
    }

    return @expanded;
}

sub _expand {
    my ($results,$str,$car,@cdr) = @_;

    if (ref $car ne 'ARRAY') {
        push @$results, $str;
        return;
    }

    for (@$car) {
        _expand( $results, $str . $_, @cdr );
    };
}

sub _attach {
    my ($t, $car, @cdr) = @_;
    return unless defined $car;
    $t->{$car} = {} unless ref $t->{$car};
    _attach( $t->{$car}, @cdr );
}

1;

__END__
=head1 NAME

String::Normal::Config;

=head1 DESCRIPTION

Base class for String::Normal configuration.

=cut
