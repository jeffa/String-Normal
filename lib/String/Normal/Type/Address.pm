package String::Normal::Type::Address;
use strict;
use warnings;
use String::Normal::Type;
use String::Normal::Config;

our $address_stem;
our $address_stop;

sub transform {
    my ($self,$value) = @_;

    $value =~ s/\([^)]*\)/ /g if $value =~ /^[^(]|[^)]$/;

    $value = String::Normal::Type::_scrub_value( $value );

    # tokenize and stem
    my @tokens = ();
    for my $token (split ' ', $value) {
        $token = defined( $address_stem->{$token} ) ? $address_stem->{$token} : $token;
        # TODO: this form of stop wording will need to be further addressed
        if (@tokens > 2) {
            last if $token eq 'apt' or $token eq 'ste';
        }
        push @tokens, $token;
    }

    # remove all middle stop words
    my @filtered = map {
        my $count = $address_stop->{middle}{$_} || '';
        (length $count and @tokens >= $count) ? () : $_;
    } @tokens;

    # revert if we filtered words down to less than 2 tokens
    @filtered = @tokens if @filtered < 2;

    return join ' ', @filtered;
}

sub new {
    my $self = shift;
    $address_stem = String::Normal::Config::AddressStem::_data( @_ );
    $address_stop = String::Normal::Config::AddressStop::_data( @_ );
    return bless {@_}, $self;
}

1;

=head1 NAME

String::Normal::Type::Address;

=head1 DESCRIPTION

This package defines substitutions to be performed on the address
and city types of a record.

=head1 METHODS

=over 4

=item C<new( %params )>

    my $address = String::Normal::Type::Address->new;

Creates a Address type.

=item C<transform( $value )>

    my $new_value = $address->transform( $value );

Transforms a value according to the rules of a Address type.

=back

=cut
