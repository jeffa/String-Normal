#!/usr/bin/env perl 

use strict;
use warnings;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use String::Normal;

my $normalizer = String::Normal->new;
print $normalizer->transform( @ARGV ), "\n";
