[![Actions Status](https://github.com/skaji/CPAN-02Packages-Search/workflows/linux/badge.svg)](https://github.com/skaji/CPAN-02Packages-Search/actions)

# NAME

CPAN::02Packages::Search - Search packages in 02packages.details.txt

# SYNOPSIS

    use CPAN::02Packages::Search;

    my $index = CPAN::02Packages::Search->new(file => '/path/to/02packages.details.txt');

    my $result1 = $index->search('Plack'); # { version => "1.0048", path => "M/MI/MIYAGAWA/Plack-1.0048.tar.gz" }
    my $result2 = $index->search('Unknown'); # undef

# DESCRIPTION

CPAN::02Packages::Search allows you to search packages in 02packages.details.txt.
Much code is taken from [CPAN::Common::Index::Mirror](https://metacpan.org/pod/CPAN%3A%3ACommon%3A%3AIndex%3A%3AMirror).

# SEE ALSO

[CPAN::Common::Index::Mirror](https://metacpan.org/pod/CPAN%3A%3ACommon%3A%3AIndex%3A%3AMirror)

# AUTHOR

Shoichi Kaji <skaji@cpan.org>

# COPYRIGHT AND LICENSE

Copyright 2021 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
