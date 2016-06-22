package String::Normal::Type;
use strict;
use warnings;

use FindBin qw($Bin);
our $PATH = "$Bin/../lib/String/Normal/Type/";

sub _slurp_file {
    my $file = join '/', $PATH, $_[0];
    my @data = ();

    open my $fh, $file or die "Can't read $file: $!\n";
    chomp( @data = map { $_ || () } map { split /\s+/, $_, 2 } <$fh> );
    close $fh;

    return @data;
}

sub _expand_ranges {
    my @expanded = ();

    for my $line (@_) {
        my @ranges = map { /(\w)-?(\w)/;[$1..$2] } $line =~ /\[(\w-?\w)+\]/g;
        $line =~ s/\[.*//;
        expand( \my @results, $line, @ranges );
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
        expand( $results, $str . $_, @cdr );
    };
}

sub _attach {
    my ($t, $car, @cdr) = @_;
    return unless defined $car;
    $t->{$car} = {} unless ref $t->{$car};
    attach( $t->{$car}, @cdr );
}

1;

__END__
=head1 NAME

String::Normal::Type::Name;

=head1 DESCRIPTION

Base class for String::Normal Types. Contains utility private methods for
producing the necessary data structures.

=cut