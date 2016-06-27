package String::Normal::Type::Zip;
use strict;
use warnings;


sub transform {
    my ($self,$value) = @_;

    # US 5 or 9 digit zip codes
    if ( $value =~ /^(\d{5})(?:[\-|\||\.|_|\s]*\d{4})?$/ ) {
        # trim zip9 down to 5 for now
        # TODO: add separate field for zip9 ( see revision 94419 for original code)
        return $1;
    }
    elsif ($value =~ /^(apo|fpo)[\-|\||\.|_|\s]*aa[\-|\||\.|_|\s]*(\d{5})$/) {
        return $2;
    }
    # Canada
    elsif ( $value =~ /^([a-z]\d[a-z])(\s|-|\||\.|_)*(\d[a-z]\d)$/ ) {
        $value = join '',$1,$3;
        return $value;
    }
    else {
        die "Invalid zip code";
    }
}

sub new {
    my $self = shift;
    return bless {@_}, $self;
}

1;

__END__
=head1 NAME

String::Normal::Type::Zip;

=head1 DESCRIPTION

This package defines substitutions to be performed on state types.

=head1 METHODS

=over 4

=item C<new( %params )>

    my $name = String::Normal::Type::Zip->new;

Creates a Zip type.

=item C<transform( $value )>

    my $new_value = $name->transform( $value );

Transforms a value according to the rules of a Zip type.

=back
