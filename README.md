[![Actions Status](https://github.com/skaji/CPAN-02Packages-Search/actions/workflows/test.yml/badge.svg)](https://github.com/skaji/CPAN-02Packages-Search/actions)

# NAME

CPAN::02Packages::Search - Search packages in 02packages.details.txt

# SYNOPSIS

    use CPAN::02Packages::Search;

    my $index = CPAN::02Packages::Search->new(file => '/path/to/02packages.details.txt');

    my $result1 = $index->search('Plack'); # { version => "1.0048", path => "M/MI/MIYAGAWA/Plack-1.0048.tar.gz" }
    my $result2 = $index->search('Does_Not_Exist'); # undef

# DESCRIPTION

CPAN::02Packages::Search allows you to search packages in the de facto standard CPAN index file `02packages.details.txt`.

# MOTIVATION

We can already search packages in `02packages.details.txt` by the excellent module [CPAN::Common::Index::Mirror](https://metacpan.org/pod/CPAN%3A%3ACommon%3A%3AIndex%3A%3AMirror).
Its functionality is not only searching packages, but also searching authors and even fetching/caching index files.

As an author of CPAN clients, I just want to search packages in `02packages.details.txt`.
So I ended up extracting functionality of searching packages from CPAN::Common::Index::Mirror as CPAN::02Packages::Search.

# PERFORMANCE

CPAN::Common::Index::Mirror and CPAN::02Packages::Search use [Search::Dict](https://metacpan.org/pod/Search%3A%3ADict), which implements binary search.
A simple benchmark shows that CPAN::02Packages::Search is 422 times faster than _naive_ search.

    ❯ perl bench/bench.pl
                   Rate naive_search   our_search
    naive_search 4.13/s           --        -100%
    our_search   1752/s       42291%           --

See [bench/bench.pl](https://github.com/skaji/CPAN-02Packages-Search/blob/main/bench/bench.pl) for details.

# SEE ALSO

[CPAN::Common::Index::Mirror](https://metacpan.org/pod/CPAN%3A%3ACommon%3A%3AIndex%3A%3AMirror)

[Search::Dict](https://metacpan.org/pod/Search%3A%3ADict)

[https://www.cpan.org/modules/04pause.html](https://www.cpan.org/modules/04pause.html)

# AUTHOR

Shoichi Kaji <skaji@cpan.org>

# COPYRIGHT AND LICENSE

Copyright 2021 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
