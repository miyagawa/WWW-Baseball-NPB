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
    is $res->home, '���';
    is $res->visitor, '���';
    is $res->score('���'), '';
    is $res->score('���'), '';
    is $res->status, '18��00ʬ';
    is $res->stadium, '����ɡ���';
}



