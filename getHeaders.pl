#!/usr/bin/perl 
#===============================================================================
#
#         FILE: getHeaders.pl
#
#        USAGE: ./getHeaders.pl  
#
#  DESCRIPTION: get functions from header files.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
#      COMPANY: 
#      VERSION: 1.0
#      CREATED: 2012Äê05ÔÂ02ÈÕ 22ʱ21·Ö20Ãë
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

if ($#ARGV  != 0) {
	print "Usage: ./getHeaders.pl filename\n";
	exit -1;
}

my $filename = shift @ARGV;

open FH, $filename or die $!;

# It's used to record the level of code or comments 
my @queue = ();
my $isComment = 0;
# We'll parse the *.h file line by line.
while (<FH>) {
	# first, we should clear the space tab etc at the head of line 
	$_ =~ s/^[\s\t]+//g;

	# ignore the comments, now we need to parse the string one by one
	# 1. /* xxxxx */ part of one line
	# 2. /* 		 multiple lines
	# 	   */
	# 3. // 		 from // to the end
	if (($_ =~ /\/\*/) and ($_ =~ /\*\\/) and ($isComment == 0)) {
		# we do not need to set the $isComment
		$_ =~ s/\/\*.*\*\\//g;
	} 
	elsif (($_ =~ /\/\*/) and (not ($_ =~ /\*\\/)) and ($isComment == 0)) {
		$_ =~ s/\/\*.*$//g;
		$isComment = 1;
	}
	elsif ((not ($_ =~ /\/\*/)) and (not ($_ =~ /\*\\/)) and ($isComment == 1)) {
		# We'll ignore the whole line
		next;
	}
	elsif ((not ($_ =~ /\/\*/)) and ($_ =~ /\*\\/) and ($isComment == 1)) {
		$_ =~ s/^.*\*\\//g;
		$isComment = 0;
	}

	print $_;
}
