#!/usr/bin/perl

use strict;
use Data::Dumper;
use DBI;

my $dsn = 'DBI:mysql:database=owncloud7';
my $dbh = DBI->connect($dsn, 'owncloud7', 'XXX');

my %storages = {};
my %ids = {};

if (@ARGV != 3 or $ARGV[0] eq '--help' or $ARGV[0] eq '-h') {
    print "Syntax:\n\ngenerate_updates.pl storages_70 file_ids_70 shares_45\n";
    exit 255;
}

open(STORAGES, '<' . $ARGV[0]) or die("Can't open storages dump");
while (<STORAGES>) {
    chomp($_);
    my ($numeric_id, $user) = split(/\t/, $_);

    $user =~ s/^home:://;

    if ($user =~ /:/) {
        # Skip this one
        next;
    }

    $storages{$user} = $numeric_id;
}

close(STORAGES);

open(FILEIDS, '<' . $ARGV[1]) or die("Can't open file ids dump");
while (<FILEIDS>) {
    chomp($_);
    my ($storage, $hash, $fileid) = split(/\t/, $_);

    if (!defined($ids{$storage})) {
        $ids{$storage} = {};
    }

    $ids{$storage}{$hash} = $fileid;
}

close(FILEIDS);

open(SHARES, '<' . $ARGV[2]) or die("Can't open shares dump");

while (<SHARES>) {
    chomp($_);
    my ($user, $path_hash, $share_with, $item_type, $file_target, $permissions, $stime, $expiration, $token) = split(/\t/, $_);

    if (!defined($storages{$user})) {
        print "Issue with share $_. $user storage does not exist\n";
        next;
    }

    my $storage = $storages{$user};

    if (!defined($ids{$storage}{$path_hash})) {
        print "Issue with share $_. File id of $storage and $path_hash does not exist\n";
        next;
    }

    my $file_id = $ids{$storage}{$path_hash};

    my $sth = $dbh->prepare("INSERT INTO oc_share "
    . "(share_type, share_with, uid_owner, item_type, item_source, item_target, file_source, file_target, permissions, stime, expiration, token) "
    . "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

    $sth->execute(
        3,
        replace_null_with_undef($share_with),
        $user,
        $item_type,
        $file_id,
        '/' . $file_id,
        $file_id,
        $file_target,
        $permissions,
        $stime,
        replace_null_with_undef($expiration),
        $token
    );
}
close(SHARES);

sub replace_null_with_undef {
    my $value = shift @_;

    if ($value eq 'null' or $value eq 'NULL') {
        return undef;
    }

    return $value;
}
