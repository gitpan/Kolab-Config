package Kolab::Config;

use 5.008;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Kolab::Config ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	%kolab_config $kolab_prefix
);

our $VERSION = '0.02';

use IO::File;
use vars qw(%kolab_config $kolab_prefix);

# Preloaded methods go here.
$kolab_prefix="/kolab";
%kolab_config = ();

my $kolab_conf = $kolab_prefix."/etc/kolab/kolab.conf";
my $fd = IO::File->new($kolab_conf, "r") || die "could not open $kolab_conf";
foreach (<$fd>) {
   if (/(.*) : (.*)/) { $kolab_config{$1} = $2; }
}
undef $fd;

$kolab_config{'bind_dn'} || die "could not read bind_dn from $kolab_conf";
$kolab_config{'bind_pw'} || die "could not read bind_pw from $kolab_conf";
$kolab_config{'ldap_uri'} || die "could not read ldap_uri from $kolab_conf";
$kolab_config{'base_dn'} || die "could not read base_dn from $kolab_conf";
$kolab_config{'php_dn'} || die "could not read php_dn from $kolab_conf";
$kolab_config{'php_pw'} || die "could not read php_pw from $kolab_conf";


1;
__END__

=head1 NAME

Kolab::Config - A Perl Module that acts as a standard interface to the
configuration settings of a Kolab server.

=head1 SYNOPSIS

  use Kolab::Config;
  
  $serverdn = $kolab_config{'base_dn'};
  #Print the server base dn
  print $serverdn;

  #Retrieve the parameters available
  print join(" ", keys(%kolab_config));

=head1 ABSTRACT

  The Kolab::Config module provides a standard interface to access 
  Kolab configuration parameters. Configuration information is 
  maintained in the $kolab_prefix/etc/kolab/kolab.conf file.

=head1 DESCRIPTION

Access Kolab configuration through this module through the exported
variables mentioned below.

=head2 EXPORT

  %kolab_config  A perl hash that contains the kolab.conf parameters. 
  
  $kolab_prefix  The prefix to the kolab tree. At this stage hardcoded
                 to /kolab

=head1 SEE ALSO

kolab-devel mailing list: <kolab-devel@lists.intevation.org>

Kolab website: http://kolab.kroupware.org

=head1 AUTHOR

Stephan Buys, s.buys@codefusion.co.za

Please report any bugs, or post any suggestions, to the kolab-devel
mailing list <kolab-devel@lists.intevation.de>.
       

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Stephan Buys

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
