package String::Normal::Type::City;
use strict;
use warnings;
use String::Normal::Type;
use String::Normal::Config;

our $address_stem;

sub transform {
    my ($self,$value) = @_;

    $value = String::Normal::Type::_scrub_value( $value );

    # TODO: refactor this code and remove dependencies on %address_stem
    # single spaced records are guaranteed
    my @tokens = ();
    for my $token (split ' ', $value) {
        $token = defined( $address_stem->{$token} ) ? $address_stem->{$token} : $token;
        push @tokens, $token;
    }

    $value = join ' ', @tokens;
}

sub new {
    my $self = shift;
    $address_stem = String::Normal::Config::AddressStem::_data( @_ );
    return bless {@_}, $self;
}

1;

__END__
=head1 NAME

String::Normal::Type::City;

=head1 DESCRIPTION

This package defines substitutions to be performed on city types.

=head1 METHODS

=over 4

=item C<new( %params )>

    my $city = String::Normal::Type::City->new;

Creates a City type.

=item C<transform( $value )>

    my $new_value = $city->transform( $value );

Transforms a value according to the rules of a City type.

=back
