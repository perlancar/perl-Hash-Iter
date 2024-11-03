package Hash::Iter;

use strict;
use warnings;

use Exporter qw(import);

# AUTHORITY
# DATE
# DIST
# VERSION

our @EXPORT_OK = qw(hash_iter pair_iter);

sub hash_iter {
    my $hash = shift;
    my $i = 0;

    my @ary = keys %$hash;
    sub {
        if ($i < @ary) {
            my $key = $ary[$i++];
            return ($key, $hash->{$key});
        } else {
            return ();
        }
    };
}

sub pair_iter {
    hash_iter({@_});
}

1;
#ABSTRACT: Generate a coderef iterator for a hash

=for Pod::Coverage .+

=head1 SYNOPSIS

  use Hash::Iter qw(hash_iter pair_iter);

  my $iter = hash_iter({1,2,3,4,5,6});
  while (my ($key,$val) = $iter->()) { ... }

  $iter = pair_iter(1,2,3,4,5,6);
  while (my ($key,$val) = $iter->()) { ... }


=head1 DESCRIPTION

This module provides a simple iterator which is a coderef that you can call
repeatedly to get pairs of a hash/hashref. When the pairs are exhausted, the
coderef will return undef. No class/object involved.

The principle is very simple and you can do it yourself with:

 my $iter = do {
     my $hash = shift;
     my $i = 0;

     my @ary = keys %$hash;
     sub {
         if ($i < @ary) {
             my $key = $ary[$i++];
             return ($key, $hash->{$key});
         } else {
             return undef;
         }
     };
  }

Caveat: if list/array contains an C<undef> element, it cannot be distinguished
with an exhausted iterator.


=head1 FUNCTIONS

=head2 hash_iter($hashref) => coderef

=head2 pair_iter(@pairs) => coderef


=head1 SEE ALSO

Array iterator modules, particularly L<Array::Iter>.

=cut
