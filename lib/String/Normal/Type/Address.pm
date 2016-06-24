package String::Normal::Type::Address;
use strict;
use warnings;
use String::Normal::Type;

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

    $value = join ' ', @filtered;


    return $value;
}

sub new {
    my $self = shift;
    $address_stem = $self->stem;
    $address_stop = $self->stop;
    return bless {@_}, $self;
}

sub stem {
    my ($self,$file) = @_;
    my %stem = String::Normal::Type::_slurp_file( $file || 'address_stem.txt' );
    return \%stem;
}

sub stop {
    my ($self,$file) = @_;

    my %stop;
    for (String::Normal::Type::_slurp_file( 'address_stop.txt' )) {
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

String::Normal::Type::Address;

=head1 DESCRIPTION

This package defines substitutions to be performed on the address
and city types of a record.

=head1 METHODS

=over 4

=item C<new( %params )>

    my $name = String::Normal::Type::Name->new;

Creates a Name type.

=item C<transform( $value )>

    my $new_value = $name->transform( $value );

Transforms a value according to the rules of a Name type.

=item C<stem( %params )>

    my %hash = String::Normal::Type::Name->stem(
        file => '/path/to/name_stem.txt',
    );

Produces stem and stop list for Name types. Accepts the following named parameters:

=back

=over 8

=item * C<file>

Path to stem file.

=back

=over 4

=item C<stop( %params )>

    my %hash = String::Normal::Type::Name->stop(
        file => '/path/to/name_stop.txt',
    );

Produces stop list for Name types. Accepts the following named parameters:

=back

=over 8

=item * C<file>

Path to stop file.

=back

=cut

1;
