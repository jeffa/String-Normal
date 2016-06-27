#!perl -T
use strict;
use warnings FATAL => 'all';
use Test::More tests => 9;

use_ok( 'String::Normal' ) or BAIL_OUT( "can't use String::Normal" );
my $obj = new_ok( 'String::Normal' ) or BAIL_OUT( "can't instantiate object" );

use_ok( 'String::Normal::Type' )            or BAIL_OUT( "can't use String::Normal::Type" );
use_ok( 'String::Normal::Type::Address' )   or BAIL_OUT( "can't use String::Normal::Type::Address" );
use_ok( 'String::Normal::Type::Name' )      or BAIL_OUT( "can't use String::Normal::Type::Name" );
use_ok( 'String::Normal::Type::Phone' )     or BAIL_OUT( "can't use String::Normal::Type::Phone" );
use_ok( 'String::Normal::Type::State' )     or BAIL_OUT( "can't use String::Normal::Type::State" );
use_ok( 'String::Normal::Type::City' )      or BAIL_OUT( "can't use String::Normal::Type::City" );
use_ok( 'String::Normal::Type::Zip' )       or BAIL_OUT( "can't use String::Normal::Type::Zip" );
