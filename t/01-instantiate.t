#!perl -T
use strict;
use warnings FATAL => 'all';
use Test::More tests => 1;

use String::Normal;
my $obj = String::Normal->new;

is $obj->transform( 'one' ), 'on',     "correct transform";
