use strict;
use Test::More 'no_plan';

use WWW::Baseball::NPB;

{
    local $^W = 0;
    *LWP::Simple::get = sub ($) {
	local $/;
	require FileHandle;
	my $handle = FileHandle->new("t/20020331-pre.html");
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
    is $res->score('巨人'), '';
    is $res->score('阪神'), '';
    is $res->status, '18時00分';
    is $res->stadium, '東京ドーム';
}



