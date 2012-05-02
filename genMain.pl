#!/usr/bin/perl 
#===============================================================================
#
#         FILE: genMain.pl
#
#        USAGE: ./genMain.pl  
#
#  DESCRIPTION: generate a main.c 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
#      COMPANY: 
#      VERSION: 1.0
#      CREATED: 2012Äê05ÔÂ01ÈÕ 10ʱ11·Ö55Ãë
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

my @langs = ();
my %lang = ();
my @files = ();
my %file = ();
my @headers = ();
my @defuncs = ();
my %defunc = ();
my @addvars = ();
my %addvar = ();
my @addfuncs = ();
my %addfunc = ();
my @opts = ();
my %opt = ();

# the lang stuff
$lang{type} = "c";
$lang{files} = \@files;
push (@langs, \%lang);

# the file stuff
$file{name} = "main.c";
$file{headers} = \@headers;
$file{defuncs} = \@defuncs;
push (@files, \%file);

# the header stuff
push (@headers, "stdio.h");
push (@headers, "stdlib.h");

# the defunc stuff
$defunc{type} = "int";
$defunc{name} = "main";
$defunc{params} = "none";
$defunc{addvars} = \@addvars;
$defunc{addfuncs} = \@addfuncs;
push (@defuncs, \%defunc);

# the opt stuff
$opt{name} = "repeat";
$opt{count} = "10";
push (@opts, \%opt);
# the addfun stuff
$addfunc{name} = "printf";
$addfunc{opts} = \@opts;
push (@addfuncs, \%addfunc);


# Now it's time to output the result
foreach my $lang (@langs) {
	print "lang $lang->{type}\n";

	foreach my $file (@{$lang->{files}}) {
		print $file->{name}, "\n";

		foreach my $header (@{$file->{headers}}) {
			print "#include <$header>\n";
		}

		foreach my $defunc (@{$file->{defuncs}}) {
			# we need a varlist to track the variables
			my @defunc_varlist = ();
			# the variables attributes
			my %var_attr = ();
			print "$defunc->{type} $defunc->{name}()\n{\n";

			foreach my $addfunc (@{$defunc->{addfuncs}}) {
				$var_attr{name} = "i";
				$var_attr{type} = "int";
				$var_attr{attr} = "iter";
				# effective range : function, file, external
				$var_attr{range} = "function";
				push (@defunc_varlist, \%var_attr);
				print "\tint i;\n";
				print "\tfor (i = 0; i < 10; i++) {\n";
				print "\t\t$addfunc->{name}(\"Add something here!\\n\");\n";
				print "\t}\n";

			}

			print "\treturn 0;\n";
			print "}\n";

		}

	}
}
