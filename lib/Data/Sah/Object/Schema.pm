package Data::Sah::Object::Schema;

# DATE
# VERSION

use 5.010;
use strict;
use warnings;

sub new {
    my ($class, $sch, $is_normalized) = @_;
    $sch //= [undef, {}, {}];

    unless ($is_normalized) {
        require Data::Sah::Normalize;
        $sch = Data::Sah::Normalize::normalize_schema($sch);
    }

    my $obj = \$sch;
    bless $obj, $class;
}

sub type {
    my $self = shift;
    if (@_) {
        my $old = ${$self}->[0];
        ${$self}->[0] = $_[0];
        return $old;
    } else {
        return ${$self}->[0];
    }
}

sub clause {
    my $self = shift;
    my $name = shift;
    if (@_) {
        my $old = ${$self}->[1]{$name};
        ${$self}->[1]{$name} = $_[0];
        return $old;
    } else {
        return ${$self}->[1]{$name};
    }
}

sub req {
    my $self = shift;
    if (@_) {
        my $old = ${$self}->[1]{req};
        ${$self}->[1]{req} = $_[0];
        return $old;
    } else {
        return ${$self}->[1]{req};
    }
}

sub delete_clause {
    my $self = shift;
    my $name = shift;
    my $old = ${$self}->[1]{$name};
    delete ${$self}->[1]{$name};
    return $old;
}

sub as_struct {
    my $self = shift;
    ${$self};
}

1;
# ABSTRACT: Represent Sah schema

=head1 METHODS

=head2 new($sch, $is_normalized) => obj

Constructor. Will create a normalized copy of C<$sch>, unless C<$is_normalized>
is true, in which case won't create a copy.

=head2 type([ $value ]) => str

Get or set type. If set, will return the old value.

=head2 clause($name[, $value]) => any

Get or set a clause. If set, will return the old value.

=head2 req([ $value ]) => bool

Shortcut for C<< $osch->clause('req'[, $value ]) >>.

=head2 delete_clause($name) => any

Delete clause named C<$name>. Return the old value.

=head2 as_struct => array

Return the schema raw data structure.

=cut
