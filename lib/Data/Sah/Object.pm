package Data::Sah::Object;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

require Exporter;
our @ISA    = qw(Exporter);
our @EXPORT = qw(sah sahn);

sub sah {
    require Data::Sah::Object::Schema;
    Data::Sah::Object::Schema->new($_[0]);
}

sub sahn {
    require Data::Sah::Object::Schema;
    Data::Sah::Object::Schema->new($_[0], 1);
}

1;
# ABSTRACT: Object-oriented interface for Sah schemas

=head1 SYNOPSIS

 use Data::Sah::Object; # automatically exports sah(), sahn()

 # sah() creates a normalized copy of schema
 $osch = sah("array*");
 $osch = sah(['array*', of => 'str*']);

 # sahn() assumes you're passing an already-normalized schema and it will not
 # create a copy
 $osch = sahn([array => {req=>1, of=>'str*'}, {}]);

 say $osch->type; # -> array
 say $osch->clause('req'); # -> 1
 say $osch->clause('of', 'int'); # set clause


=head1 DESCRIPTION

L<Sah> works using pure data structures, but sometimes it's convenient to have
an object-oriented interface (wrapper) for those data. This module provides just
that.


=head1 FUNCTIONS

=head2 sah $sch => OBJECT

Exported by default. A shortcut for Data::Sah::Object::Schema->new($sch).

=head2 sahn $sch => OBJECT

Exported by default. A shortcut for Data::Sah::Object::Schema->new($sch, 1).


=head1 SEE ALSO

L<Sah>, L<Data::Sah>

=cut
