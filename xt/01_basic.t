use v5.24;
use warnings;
use experimental qw(lexical_subs signatures);
use Test2::V0;

use CPAN::02Packages::Search;

my $index = CPAN::02Packages::Search->new(file => "xt/02packages.details.txt");

is $index->search('Foo'), undef;
is $index->search('AC::MrGamoo::Job'), {
    version => undef,
    path => 'S/SO/SOLVE/AC-MrGamoo-1.tar.gz',
};

done_testing;
