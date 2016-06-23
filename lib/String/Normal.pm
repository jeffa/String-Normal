package String::Normal;
use strict;
use warnings;
our $VERSION = '0.01';

use String::Normal::Type::Name;

use Lingua::Stem;
our $STEM;
our %name_stop;
our %name_compress;

sub new {
    my $self = shift;
    $STEM = Lingua::Stem->new;
    $STEM->add_exceptions( String::Normal::Type::Name->stem ); 
    %name_stop     = %{ String::Normal::Type::Name->stop };
    %name_compress = %{ String::Normal::Type::Name->compress };
    return bless {@_}, $self;
}

# currently only handles name types
sub transform {
    my ($self,$value) = @_;

    # tokenize and stem
    my (@digits,@words);
    _tokenize_name( $value, \@digits, \@words );
    $STEM->stem_in_place( @words );

    # Remove "special" beginning and/or ending stopwords, if such words are present
    # and enough tokens are in place to remove them safely.
    if (@words) {
        # make a copy of @words and whittle it down
        my @copy = @words;
        my $count;
        if ($count = $name_stop{first}->{$copy[0]}) {
            shift @copy if @copy >= $count;
        }
        if (@copy and $count = $name_stop{last}->{$copy[-1]}) {
            pop @copy if @copy >= $count;
        }

        # reverting back if overnormalization occurs
        @words = @copy if @copy;
    }

    # Remove all middle stop words that are safe to remove, based on the number of
    # tokens, of course.
    my @filtered = map {
        my $count = $name_stop{middle}->{$_} || '';
        (length $count and @words >= $count) ? () : $_;
    } @words;

    # If we filtered all words out, "revert" to the full array of stemmed tokens.
    @filtered = @words unless @filtered;

    # The canon name is the sorted filtered stemmed words plus the original digits.
    $value = join ' ', sort @digits, @filtered;

    # Mark this record as an error if we removed every single token.  Should not happen.
#    unless (length $value) {
#        return $value, @{ $errors{EMPTY_NAME} };
#    }

    return $value;
}

sub _tokenize_name {
    my ($value,$digits,$words) = @_;

    $value = _scrub_value( $value );

    # split tokens on more than just whitespace:
    # split digits from words but keep things like 3D and 1st combined,
    # also split things like abcd#efgh but keep pound signs for #2 and # 1 and #
    # prevent the empty string from finding its way into the token list as well
    my @tokens = map { map length $_ ? $_ : (), split /##+|\s+|#+\b|\b#+/, $_ } $value =~ /(?:\d+\w{1,2}\b|\d+|\D+)/g;

    # walk each token thru the tree and create markers
    my @pairs = _mark_pairs( \@tokens );
    _compress_list( \@tokens, \@pairs ) if @pairs;

    # separate out tokens that contain digits (snowball stemmer will scrub all digits)
    for (@tokens) {
        if (/\d/) {
            push @$digits, $_;
        } else {
            push @$words, $_;
        }
    }
}

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


sub _mark_pairs {
    my $tokens = shift;
    my @pairs = ();
    for my $i (0 .. $#$tokens) {
        my $token = $tokens->[$i];
        next unless exists $name_compress{$token};
        next if $i + 1 > $#$tokens;
        my $end = _walk_tree( $i + 1, $tokens, $name_compress{$token} );
        if ($end) {
            push @pairs, [$i,$end];
            $i = $end;
        }
    }
    return @pairs;
}


sub _walk_tree {
    my ($i, $list, $tree) = @_;

    if (my $t = $tree->{$list->[$i]}) {
        if (ref $t eq 'HASH' and !%$t) {
            return $i;
        } else {
            _walk_tree( $i + 1, $list, $t );
        }
    }
}

sub _compress_list {
    my ($list,$pairs) = @_;
    for my $pair (reverse @$pairs) {
        my ($s,$e) = @$pair;
        splice @$list, $s, $e - $s + 1, join '', @$list[$s .. $e];
    }
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
