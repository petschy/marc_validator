#!/usr/bin/perl

use strict;
use warnings;

use SB;
use MARC::File::USMARC;
use MARC::Lint::CodeData;
use MARC::Lint::CodeData qw(%LanguageCodes %ObsoleteLanguageCodes );

my $lint = new 	SB;


my $marcfile = "test.mrc";

# my $marcfile = shift;

my $warnings = "warnings.txt";
open WARNINGS, ">:encoding(utf8)", $warnings
  or die "Kann $warnings nicht öffnen $!";
binmode( WARNINGS, ":utf8" );
binmode( STDOUT,   ":utf8" );
my $file = MARC::File::USMARC->in($marcfile);

while ( my $marc = $file->next() ) {
	$lint->check_record($marc);
	# Print warnings
	if ( length( $lint->warnings gt 0 ) ) {
		print $lint->warnings;
		print WARNINGS sort $lint->warnings;
	}
}    # while

close WARNINGS;
