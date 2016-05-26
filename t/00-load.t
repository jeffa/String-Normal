#!perl -T
use strict;
use warnings FATAL => 'all';
use Test::More tests => 2;

use_ok( 'String::Normal' ) or BAIL_OUT( "can't use module" );
my $obj = new_ok( 'String::Normal' ) or BAIL_OUT( "can't instantiate object" );
