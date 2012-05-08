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

# the main 
if ( $#ARGV != 0 ) {
    print "Usage: ./getHeaders.pl filename\n";
    exit -1;
}

# the dict hash is used to store the keywords
my @dict = ();
my $tmp_ref = {};

$tmp_ref  = \{ "/*" => "comments start"};
push ( @dict, $tmp_ref );
$tmp_ref  = \{ "*/" => "comments end"};
push ( @dict, $tmp_ref );
$tmp_ref  = \{ "//" => "one line comments"};
push ( @dict, $tmp_ref );

my $filename = shift @ARGV;

open FH, $filename or die $!;

#filter_comments(\*FH);
filter_dictionary(\*FH);

close FH;


# The subroutines
sub filter_comments {

	my $file = shift;
    # It's used to record the level of code or comments
    my $isComment = 0;

    # We'll parse the *.h file line by line.
    while (<$file>) {
        chomp $_;

        # first, we should clear the space tab etc at the head of line
        $_ =~ s/^[\s\t]+//g;

        ######################################################################
        #
        # This part is -just- used to clean the comments,
        # because it's possible to see both #xxx and comments
        # in one line, so if you want to clean the '#' start defines,
        # it's better to do a new part process for '#'
        #
        ######################################################################
        # /* xxxx */
        if ( ( $_ =~ /\/\*/ ) and ( $_ =~ /\*\// ) and ( $isComment == 0 ) ) {

            # we do not need to set the $isComment
            $_ =~ s/\/\*.*\*\///g;
        }

        # /* ...
        elsif ( ( $_ =~ /\/\*/ )
            and ( not( $_ =~ /\*\// ) )
            and ( $isComment == 0 ) )
        {
            $_ =~ s/\/\*.*$//g;
            $isComment = 1;
        }

        # in the comments
        elsif ( ( not( $_ =~ /\*\// ) ) and ( $isComment == 1 ) ) {

            # We'll ignore the whole line
            next;
        }

        # ... */
        elsif ( ( $_ =~ /\*\// ) and ( $isComment == 1 ) ) {
            $_ =~ s/^.*\*\///g;
            $isComment = 0;
        }

        # // ...
        elsif ( ( $_ =~ /\/\// ) and ( $isComment == 0 ) ) {
            $_ =~ s/\/\/.*//g;
        }
        else {
        }

        # clean #xxx, ignore all the line
        if ( ( $_ =~ /#[\s\w]+/ ) and ( $isComment == 0 ) ) {
            next;
        }

        # leave out the blank line
        if ( $_ eq "" ) {
            next;
        }

        print $_, "\n";

    }
}

sub filter_dictionary {
	my $fd = shift;

	while (<$fd>) {
        chomp $_;

        # first, we should clear the space tab etc at the head of line
        $_ =~ s/^[\s\t]+//g;
		my $tmp = substr($_, 0, 2);
		print $tmp, "\n";

		foreach my $ref (@dict) {

		}

	}

}
