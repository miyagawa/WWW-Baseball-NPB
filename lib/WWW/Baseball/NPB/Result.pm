package WWW::Baseball::NPB::Result;

use strict;
use vars qw($VERSION);
$VERSION = 0.01;

sub new {
    my($class, %p) = @_;
    bless {%p}, $class;
}

sub score {
    my($self, $name) = @_;
    return $self->{score}->{$name};
}

no strict 'refs';
for my $meth (qw(home visitor league status stadium)) {
    *$meth = sub { shift->{$meth} };
}

1;
__END__

=head1 NAME

WWW::Baseball::NPB::Result - Japanese baseball result class

=head1 SYNOPSIS

See L<WWW::Baseball::NPB>.

=head1 DESCRIPTION

WWW::Baseball::NPB::Result is a class which rerpresents the actual
result of Japanese baseball.

=head1 AUTHOR

Tatsuhiko Miyagawa E<lt>miyagawa@bulknews.netE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<WWW::Baseball::NPB>

=cut
