#!/usr/bin/perl 
#===============================================================================
#
#         FILE: XmlSmart.pl
#
#        USAGE: ./XmlSmart.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
#      COMPANY: 
#      VERSION: 1.0
#      CREATED: 2012Äê04ÔÂ30ÈÕ 17ʱ07·Ö53Ãë
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

use XML::Smart;

my $xml = XML::Smart->new();

my $name = {
	name => 'liunx',
};

my $obj = {
	os => $name,
	type => 'ubuntu',
	version => '12.04',
	address => '192.168.110.1',
};

push (@{$xml->{root}{obj}}, $obj);
push (@{$xml->{root}{obj}}, $obj);

$xml->save('test.xml');

# access the node
print $xml->{root}{obj}[0]{type};
