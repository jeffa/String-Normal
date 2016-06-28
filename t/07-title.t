#!perl -T
use strict;
use warnings FATAL => 'all';
use Test::More tests => 3;

use String::Normal;
my $obj = String::Normal->new( type => 'title' );

is $obj->transform( 'Blade Runner 1982 1080p.avi' ),                    'blade runner 1982',        "correct transform";
is $obj->transform( 'Alien 1979 1080p.mp4' ),                           'alien 1979',               "correct transform";
is $obj->transform( 'Voyage to the Bottom of the Sea 1961 720p.mp4' ),  'voyage btm sea 1961',      "correct transform";
