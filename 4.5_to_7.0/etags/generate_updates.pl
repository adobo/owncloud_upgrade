#!/usr/bin/perl

use strict;
use Data::Dumper;

my %etags = {};

if (@ARGV != 2 or $ARGV[0] eq '--help' or $ARGV[0] eq '-h') {
    print "Syntax:\n\ngenerate_updates.pl storages_70 etags_45\n";
    exit 255;
}

open(ETAGS, '<' . $ARGV[1]) or die("Can't open etags dump");

while (<ETAGS>) {
    chomp($_);
    my ($user, $path, $path_hash, $etag) = split(/\t/, $_);

    if (!defined($etags{$user})) {
        $etags{$user} = {};
    }
    $etags{$user}{$path_hash} = $etag;
}
close(ETAGS);

open(STORAGES, '<' . $ARGV[0]) or die("Can't open storages dump");
while (<STORAGES>) {
    chomp($_);
    my ($numeric_id, $user) = split(/\t/, $_);

    $user =~ s/^home:://;

    if ($user =~ /:/) {
    # Skip this one
        next;
    }

    foreach my $hash (keys %{$etags{$user}}) {
        my $etag = $etags{$user}{$hash};
        print "UPDATE oc_filecache SET etag='".$etag."' WHERE storage = '". $numeric_id
            ."' AND `path_hash`='".$hash."';\n";
    }

}

close(STORAGES);
