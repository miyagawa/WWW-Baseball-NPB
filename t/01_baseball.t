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
    is $res->home, '���';
    is $res->visitor, '���';
    is $res->score('���'), 1;
    is $res->score('���'), 3;
    is $res->status, '��λ';
    is $res->stadium, '����ɡ���';
}

{
    my @results = $baseball->results('pacific');
    is @results, 3;

    isa_ok $_, 'WWW::Baseball::NPB::Result' for @results;

    my $res = $results[0];
    is $res->league, 'pacific';
    is $res->home, '��Ŵ';
    is $res->visitor, '����å���';
    is $res->score('��Ŵ'), 6;
    is $res->score('����å���'), 3;
    is $res->status, '��λ';
    is $res->stadium, '���ɡ���';
}



