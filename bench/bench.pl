#!/usr/bin/env perl
use strict;
use warnings;

use lib "../lib", "lib";

use Benchmark 'cmpthese';
use CPAN::02Packages::Search;
use FindBin '$Bin';
use HTTP::Tiny;

chdir $Bin;
my $file = "02packages.details.txt";
if (!-f $file) {
    my $url = "https://cpan.metacpan.org/modules/02packages.details.txt.gz";
    my $res = HTTP::Tiny->new->mirror($url => "$file.gz");
    die "$res->{status} $url\n" if !$res->{success};
    !system "gzip -d --stdout $file.gz > $file" or die;
}

package CPAN::02Packages::NaiveSearch {
    sub new {
        my ($class, %argv) = @_;
        my $file = $argv{file};
        open my $fh, "<", $file or die "$!: $file\n";
        while (my $line = <$fh>) {
            last if $line =~ /\A\s*\Z/;
        }
        my $first = tell $fh;
        bless { fh => $fh, first => $first }, $class;
    }
    sub search {
        my ($self, $package) = @_;
        my $fh = $self->{fh};
        seek $fh, $self->{first}, 0;
        while (my $line = <$fh>) {
            if ($line =~ /\A\Q$package\E\s/) {
                chomp $line;
                my (undef, $version, $path) = split /\s+/, $line, 4;
                $version = undef if $version eq 'undef';
                return { version => $version, path => $path };
            }
        }
        return;
    }
}

my $our_search = CPAN::02Packages::Search->new(file => $file);
my $naive_search = CPAN::02Packages::NaiveSearch->new(file => $file);

cmpthese -1, {
    our_search => sub {
        $our_search->search('App::cpm');
        $our_search->search('Plack');
        $our_search->search('Does_Not_Exists');
    },
    naive_search => sub {
        $naive_search->search('App::cpm');
        $naive_search->search('Plack');
        $naive_search->search('Does_Not_Exists');
    },
};
