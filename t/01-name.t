#!perl -T
use strict;
use warnings FATAL => 'all';
use Test::More tests => 4;

use String::Normal;
my $obj = String::Normal->new;

is $obj->transform( 'one' ),                'on',               "correct transform";
is $obj->transform( 'The Bakery Store' ),   'bakeri store',     "correct transform";
is $obj->transform( 'The Bakeries Store' ), 'bakeri store',     "correct transform";
is $obj->transform( 'The The' ),            'the the',          "correct transform";
