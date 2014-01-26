#!/usr/bin/perl

use strict;

my $first = 1;

print "{\n";
print "\t\"data\":[\n\n";

my $vzresult = `sudo /usr/sbin/vzlist -a -o veid,hostname,status,laverage -H`;

my @lines = split /\n/, $vzresult;

foreach my $l (@lines) {
        if ($l =~ /^(\s*?)(\d+) (.*?)(\s+)(\S+)/)
        {
                my $id = $2;
                my $hostname = $3;
                my $status = $5;
                print ",\n" if not $first;
                $first = 0;

                print "\t{\n";
                print "\t\t\"{#VZID}\":\"$id\",\n";
                print "\t\t\"{#VZHOST}\":\"$hostname\",\n";
                print "\t\t\"{#VZSTATUS}\":\"$status\"\n";
                print "\t}";
        }
}

print "\n\t]\n";
print "}\n";

