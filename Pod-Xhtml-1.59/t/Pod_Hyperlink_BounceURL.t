#!/usr/local/bin/perl
# $Revision: 1.3 $

use strict;
use Test::Assertions::TestScript;
use Pod::Hyperlink::BounceURL;
use Pod::Xhtml;

ASSERT($Pod::Hyperlink::BounceURL::VERSION, "Loaded $Pod::Hyperlink::BounceURL::VERSION");

my $canned = 'd.xhtml';

my $lp = new Pod::Hyperlink::BounceURL;
$lp->configure( URL => '/apps/trampoline.rb?p=%s&n=%s&s=1' );
DUMP($lp);
ASSERT($lp, "created linkparser object");

my $px = new Pod::Xhtml(StringMode => 1, LinkParser => $lp);
DUMP($px);
ASSERT($px, "created pod parser object");

$px->parse_from_file( 'd.pod' );
my $xhtml = $px->asString;
$xhtml =~ s/^.*<body/<body/s;
$xhtml =~ s!</html>.*!!s;
DUMP("Made this XHTML >>>$xhtml<<<");

ASSERT(EQUALS_FILE($xhtml, $canned), "Generated XHTML matched expected XHTML");
