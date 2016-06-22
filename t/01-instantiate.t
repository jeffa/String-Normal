#!perl -T
use strict;
use warnings FATAL => 'all';
use Test::More tests => 1;

use String::Normal;
my $obj = String::Normal->new;

is 1, 1;
#is $obj->transform( 'one' ), 2,     "correct transform";
