#!/usr/bin/perl 
#===============================================================================
#
#         FILE: autocode.pl
#
#        USAGE: ./autocode.pl  
#
#  DESCRIPTION: a experiments for auto coding
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
#      COMPANY: 
#      VERSION: 1.0
#      CREATED: 2012Äê04ÔÂ30ÈÕ 21ʱ16·Ö21Ãë
#     REVISION: ---
#===============================================================================

use strict;
use warnings;


# The array is used to store head files.
my @headers = ();

push (@headers, "stdio.h");
push (@headers, "stdlib.h");

# We need a hash tables to store the contents of a function
my %func = ();
$func{name} = "main";
$func{type} = "int";
$func{calls} = {
	name => "printf",
	type => "int",
	params => "const char *",
	string => "\"hello, world!\\n\"",
};

# Now, let's try to generate a main function
# the headers
foreach my $element (@headers) {
	print "#include <$element>\n";
}

# the function
# TODO add params process
print "$func{type} $func{name}()\n";
print "{\n"; 
my $call = $func{calls};
print "\t$call->{name}($call->{string});\n";

print "\treturn 0;\n";
print "}\n";
# the end
