package String::Normal::Type::Name;
use strict;
use warnings;
use String::Normal::Type;
use String::Normal::Config;

use Lingua::Stem;
our $STEM;
our $name_stop;
our $name_compress;

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
        if ($count = $name_stop->{first}{$copy[0]}) {
            shift @copy if @copy >= $count;
        }
        if (@copy and $count = $name_stop->{last}{$copy[-1]}) {
            pop @copy if @copy >= $count;
        }

        # reverting back if overnormalization occurs
        @words = @copy if @copy;
    }

    # Remove all middle stop words that are safe to remove, based on the number of
    # tokens, of course.
    my @filtered = map {
        my $count = $name_stop->{middle}{$_} || '';
        (length $count and @words >= $count) ? () : $_;
    } @words;

    # If we filtered all words out, "revert" to the full array of stemmed tokens.
    @filtered = @words unless @filtered;

    # The canon name is the sorted filtered stemmed words plus the original digits.
    return join ' ', sort @digits, @filtered;
}

sub new {
    my $self = shift;
    $STEM = Lingua::Stem->new;
    $STEM->add_exceptions( String::Normal::Config::NameStem::_data );  #TODO: override default files
    $name_stop     = String::Normal::Config::NameStop::_data;
    $name_compress = String::Normal::Config::NameCompress::_data;
    return bless {@_}, $self;
}

sub _tokenize_name {
    my ($value,$digits,$words) = @_;

    $value = String::Normal::Type::_scrub_value( $value );

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

sub _mark_pairs {
    my $tokens = shift;
    my @pairs = ();
    for my $i (0 .. $#$tokens) {
        my $token = $tokens->[$i];
        next unless exists $name_compress->{$token};
        next if $i + 1 > $#$tokens;
        my $end = _walk_tree( $i + 1, $tokens, $name_compress->{$token} );
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

String::Normal::Type::Name;

=head1 DESCRIPTION

This package defines substitutions to be performed on the name types.

=head1 METHODS

=over 4

=item C<new( %params )>

    my $name = String::Normal::Type::Name->new;

Creates a Name type. Accepts the following named parameters:

=back

=over 8

=item * C<name_stem>

=item * C<name_stop>

=item * C<name_compress>

=item * C<address_stem>

=item * C<address_stop>

=item * C<area_codes>

=item * C<states>

=back

=over 4

=item C<transform( $value )>

    my $new_value = $name->transform( $value );

Transforms a value according to the rules of a Name type.

=back
