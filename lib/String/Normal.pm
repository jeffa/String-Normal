package String::Normal;
use strict;
use warnings;
our $VERSION = '0.01';

use String::Normal::Type::Name;
use String::Normal::Type::Address;

sub new {
    my $package = shift;
    my $self = {@_};

    if (!$self->{type} or $self->{type} eq 'name') {
        $self->{normalizer} = String::Normal::Type::Name->new;
    } elsif ($self->{type} eq 'address') {
        $self->{normalizer} = String::Normal::Type::Address->new;
    } else {
        die "type $self->{type} is not implemented\n";
    }

    return bless $self, $package;
}

# currently only handles name types
sub transform {
    my ($self,$value,$type) = @_;

    $value = lc( $value );      # lowercase
    $value =~ tr/  //s;         # squeeze multiple spaces to one
    $value =~ s/^ //;           # trim leading space
    $value =~ s/ $//;           # trim trailing space

    # strip out control chars except tabs, lf's, cr's, r single quote, mdash and ndash
    $value =~ s/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F-\x91\x93-\x95\x98-\x9F]//g;

    return $self->{normalizer}->transform( $value );
}

1;

__END__
=head1 NAME

String::Normal - Transform strings into a normal form.

=head1 SYNOPSIS

    use String::Normal;
    my $normalizer = String::Normal->new;

=head1 DESCRIPTION

THIS MODULE IS AN ALPHA RELEASE!

Normalize your strings.

=head1 METHODS

=over 4

=item C<new( %params )>

  my $normalizer = String::Normal->new;

Constructs object. Accepts the following named parameters:

=back

=over 8

=item * C<name_stem>

Placeholder.

=back

=over 4

=item C<transform( $word )>

  my $new = $normalizer->transform( "Donie's Bagels & Donuts" );

Normalizes word.

=back

=head1 AUTHOR

Jeff Anderson, C<< <jeffa at cpan.org> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to either

=over 4

=item * Email: C<bug-string-normal at rt.cpan.org>

=item * Web: L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=String-Normal>

=back

I will be notified, and then you'll automatically be notified of progress
on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc String::Normal

The Github project is L<https://github.com/jeffa/String-Normal>

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here) L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=String-Normal>

=item * AnnoCPAN: Annotated CPAN documentation L<http://annocpan.org/dist/String-Normal>

=item * CPAN Ratings L<http://cpanratings.perl.org/d/String-Normal>

=item * Search CPAN L<http://search.cpan.org/dist/String-Normal/>

=back

=head1 ACKNOWLEDGEMENTS

The following people contributed algorithms and strategies in addition to the author. Thank you very much! :)

=over 4

=item * Gauthier Groult

=item * Christophe Louvion

=item * Virginie Louvion

=item * Ana Martinez

=item * Ray Toal

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2016 Jeff Anderson.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut
