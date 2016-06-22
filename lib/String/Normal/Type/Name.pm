package String::Normal::Type::Name;
use strict;
use warnings;

=head1 NAME

String::Normal::Type::Name;

=head1 DESCRIPTION

This package defines substitutions to be performed on the name types.

=cut

# Lingua::Stem exceptions
my %exceptions;

# the pound sign is always troublesome in perl
$exceptions{'#'} = 'no';

my %deletions = (
    de           => '',
    da           => '',
    du           => '',
    'le'         => '',
    'and'        => '',
    the          => '',
    of           => '',
    from         => '',
    inc          => '',
    incorporated => '',
);

my %hashmap = ( %exceptions, %deletions );

# Export the variable $hashmap as a reference to the hash
our $hashmap = \%hashmap;

1;
