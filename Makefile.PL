use strict;
use warnings;
use ExtUtils::MakeMaker;

# Normalize version strings like 6.30_02 to 6.3002,
# so that we can do numerical comparisons on it.
my $eumm_version = $ExtUtils::MakeMaker::VERSION;
$eumm_version =~ s/_//;

WriteMakefile(
  NAME         => 'Dancer::App::Base::HTML5Bootstrap',
  AUTHOR       => q{Colin Keith <ckeith@cpan.org>},
  VERSION_FROM => 'lib/Dancer/App/Base/HTML5Bootstrap.pm',
  ABSTRACT     => 'Base Application for Dancer using HTML5 and Bootstrap 3',
  (
    $eumm_version >= 6.3001
    ? ( 'LICENSE' => 'perl' )
    : ()
  ),
  PL_FILES  => {},
  PREREQ_PM => {
    'Test::More'                        => 0,
    'YAML'                              => 0,
    'Dancer'                            => 1.3119,
    'Dancer::Debug'                     => 0,
    'Dancer::Plugin::Ajax'              => 0,
    'Dancer::Plugin::Auth::Extensible'  => 0.30,
    'Dancer::Plugin::CDN'               => 0,
    'Dancer::Plugin::DebugToolbar'      => 0,
    'Dancer::Plugin::NYTProf'           => 0,
    'Dancer::Plugin::Facebook'          => 0,
    'Plack::Middleware::Deflater'       => 0,
    'Plack::Middleware::Debug'          => 0,
    'Plack::Middleware::GeoIP'          => 0,
    'Plack::Middleware::ConditionalGET' => 0,
    'Plack::Middleware::ETag'           => 0,
  },
  dist => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
  clean => { FILES => 'Dancer-App-Base-HTML5Bootstrap-*' },
);
