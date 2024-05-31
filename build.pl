#!/usr/bin/env perl

use FindBin '$RealBin';

use lib "$RealBin/modules/metamage_1/tools/perl/";

use Compile::Driver;

use warnings FATAL => 'all';
use strict;

Compile::Driver::main( @ARGV );
