use strict;
use Test::More tests => 25;

use WWW::Baseball::NPB;

{
    local $^W = 0;
    *LWP::Simple::get = sub ($) {
	local $/;
	require FileHandle;
	my $handle = FileHandle->new("t/20020330.html");
	return <$handle>;
    };
}

my $baseball = WWW::Baseball::NPB->new;

{
    my @results = $baseball->results;
    is @results, 6;

    isa_ok $_, 'WWW::Baseball::NPB::Result' for @results;

    my $res = $results[0];
    is $res->league, 'central';
    is $res->home, '巨人';
    is $res->visitor, '阪神';
    is $res->score('巨人'), 1;
    is $res->score('阪神'), 3;
    is $res->status, '終了';
    is $res->stadium, '東京ドーム';
}

{
    my @results = $baseball->results('pacific');
    is @results, 3;

    isa_ok $_, 'WWW::Baseball::NPB::Result' for @results;

    my $res = $results[0];
    is $res->league, 'pacific';
    is $res->home, '近鉄';
    is $res->visitor, 'オリックス';
    is $res->score('近鉄'), 6;
    is $res->score('オリックス'), 3;
    is $res->status, '終了';
    is $res->stadium, '大阪ドーム';
}



