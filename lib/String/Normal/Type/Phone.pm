package String::Normal::Type::Phone;
use strict;
use warnings;

use String::Normal::Config::AreaCodes;

our $codes;

sub transform {
    my ($self,$value) = @_;

    # Replace phone letters with numbers and remove non-digits (credit Ray Toal)
    $value =~ tr/a-z/22233344455566677778889999/;
    $value =~ s/\D//g;

    # remove any leading 1 from 11 digit number
    $value =~ /^1\d{10}$/ and substr( $value, 0, 1 ) = '';

    if (length($value) != 10) {
        die "invalid length";
    }

    # validate area code (first digit cannot be 1 or 0)
    my $areacode_first = substr $value, 0, 1;
    if ($areacode_first < 2) {
        die "invalid area code";
    }

    return $value;
}

sub new {
    my $self = shift;
    $codes = String::Normal::Config::AreaCodes::_data( @_ );
    return bless {@_}, $self;
}

1;

__END__
=head1 NAME

String::Normal::Type::Phone;

=head1 DESCRIPTION

This package defines a set of valid North American
telephone area codes used in phone validation.

=head1 METHODS

=over 4

=item C<new( %params )>

    my $phone = String::Normal::Type::Phone->new;

Creates a Phone type. Accepts the following named parameters:

=back

=over 8

=item * C<area_codes>

Path to text file to override default area codes.

=back

=over 4

=item C<transform( $value )>

    my $new_value = $phone->transform( $value );

Transforms a value according to the rules of a Phone type.

=back
