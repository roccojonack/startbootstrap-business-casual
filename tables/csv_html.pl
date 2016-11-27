#! /usr/bin/perl
#
# Purpose : this script takes a csv file in and converts it into a colored HTML formated file
#           color code is format specific
#

use HTML::Entities;
 
sub row {
    my $elem = shift;
    my @cells = map {"<$elem>$_</$elem>"} split ',', shift;
    print '<tr>', @cells, "</tr>\n";
}
 
my ($first, @rest) = map
    {my $x = $_; chomp $x; encode_entities $x}
    <STDIN>;

print "<table>\n";
row @ARGV ? 'th' : 'td', $first;
# row 'td style=\'color:#000; background:#8FF; border:1px #000 solid; padding:0.6em;\'', $_ foreach @rest;
foreach $i (@rest) {
  $color = "#FF0000";
  @fields = split(/,/,$i);
  # print "Debug: $fields[0], $fields[1], $fields[4], $fields[5]\n";
  if (! ($fields[0] eq "mismatch")) {
    $color = "#0000FF";
    # print "Debug: $fields[0], $fields[1], $fields[4], $fields[5]\n";
    @AddressFields  = split(/\//,$fields[1]);
    @AddressFields1 = split(/\//,$fields[4]);
    @AddressFields2 = split(/\//,$fields[5]);
    if ($AddressFields[0] eq $AddressFields[1]) {
      $color = "#FFFF00";
      if (($AddressFields1[0] eq $AddressFields1[1]) && ($AddressFields2[0] eq $AddressFields2[1]) ) {
	# print "Debug: got it $fields[0], $fields[1], $fields[4], $fields[5]\n";
	$color = "#00FF00";
      };
    };
  };
  row "td style=\'color:#000; background:$color; border:1px #000 solid; padding:0.6em;\'", $i;
};
print "</table>\n";
