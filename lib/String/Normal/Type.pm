package String::Normal::Type;
use strict;
use warnings;

use String::Normal::Type::Name;
use String::Normal::Type::Address;
use String::Normal::Type::Phone;
use String::Normal::Type::State;
use String::Normal::Type::City;
use String::Normal::Type::Zip;

sub _scrub_value {
    my $value = shift;

    $value = _deaccent_value( $value );
    $value =~ tr/'//d;

    # replace all rejected charactes with space
    $value =~ s/[^a-z0-9#]/ /g;

    return $value
}

sub _deaccent_value {
    my $value = shift;

    # remove decorations and stem variations of single quotes
    $value =~ tr[àáâãäåæçèéêëìíîïñòóôõöøùúûüýÿ’`\x92]
                [aaaaaaaceeeeiiiinoooooouuuuyy'''];

    return $value;
}

1;

__END__
=head1 NAME

String::Normal::Type::Name;

=head1 DESCRIPTION

Base class for String::Normal Types. Contains utility private methods for
producing the necessary data structures.

=cut
