package String::Normal::Type::Name;
use strict;
use warnings;
use String::Normal::Type;

# i do not currently remember how exception/deletions work

# Lingua::Stem exceptions
# the pound sign is always troublesome in perl
my %exceptions;
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

sub stem {
    my ($self,$file) = @_;
    my %stem = String::Normal::Type::_slurp_file( $file || 'name_stem.txt' );
    return \%stem;
}

sub stop {
    my ($self,$file) = @_;

    my %stop;
    for (String::Normal::Type::_slurp_file( $file || 'name_stop.txt' )) {
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

sub compress {
    my ($self,$file) = @_;

    my %compress;
    for (String::Normal::Type::_expand_ranges( String::Normal::Type::_slurp_file( $file || 'name_compress.txt' ))) {
        String::Normal::Type::_attach( \%compress, split '-', $_ );
    }

    return \%compress;
}

1;

__END__
=head1 NAME

String::Normal::Type::Name;

=head1 DESCRIPTION

This package defines substitutions to be performed on the name types.

=head1 METHODS

=over 4

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

=over 4

=item C<compress( %params )>

    my %hash = String::Normal::Type::Name->compress(
        file => '/path/to/name_compress.txt',
    );

Produces compress list for Name types. Accepts the following named parameters:

=back

=over 8

=item * C<file>

Path to compress file.

=back

=cut

