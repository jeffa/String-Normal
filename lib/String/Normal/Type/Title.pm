package String::Normal::Type::Title;
use strict;
use warnings;
use String::Normal::Type;
use String::Normal::Config;

use Lingua::Stem;
our $STEM;
our $title_stem;
our $title_stop;

sub transform {
    my ($self,$value) = @_;

    $value =~ s/\([^)]*\)/ /g if $value =~ /^[^(]|[^)]$/;

    $value = String::Normal::Type::_scrub_value( $value );

    # tokenize and stem
    my @tokens = ();
    for my $token (split ' ', $value) {
        $token = defined( $title_stem->{$token} ) ? $title_stem->{$token} : $token;
        push @tokens, $token;
    }

    # remove all middle stop words
    my @filtered = map {
        my $count = $title_stop->{middle}{$_} || '';
        (length $count and @tokens >= $count) ? () : $_;
    } @tokens;

    # revert if we filtered words down to less than 2 tokens
    @filtered = @tokens if @filtered < 2;

    return join ' ', @filtered;
}

sub new {
    my $self = shift;
    $title_stem = String::Normal::Config::TitleStem::_data();
    $title_stop = String::Normal::Config::TitleStop::_data();
    return bless {@_}, $self;
}


1;

__END__
=head1 NAME

String::Normal::Type::Title;

=head1 DESCRIPTION

This package defines substitutions to be performed on title types, such as the titles
for movies, film and television shows.

=head1 METHODS

=over 4

=item C<new( %params )>

    my $title = String::Normal::Type::Title->new;

Creates a Title type. Accepts the following named parameters:

=back

=over 8

=item * C<title_stem>

=item * C<title_stop>

=back

=over 4

=item C<transform( $value )>

    my $new_value = $title->transform( $value );

Transforms a value according to the rules of a title type.

=back