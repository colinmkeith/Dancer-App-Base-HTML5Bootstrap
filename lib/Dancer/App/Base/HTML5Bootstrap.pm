package Dancer::App::Base::HTML5Bootstrap;

# Preamble per http://www.perl.com/pub/2012/04/perlunicook-standard-preamble.html
use utf8;                          # so literals and identifiers can be in UTF-8
use v5.16;                         # or later to get "unicode_strings" feature
use strict;                        # quote strings, declare variables
use warnings;                      # on by default
use warnings qw(FATAL utf8);       # fatalize encoding glitches
use open qw(:std :utf8);           # undeclared streams in UTF-8
use charnames qw(:full :short);    # unneeded in v5.16

use Dancer ':syntax';

use Dancer::Plugin::Ajax;
use Dancer::Plugin::Auth::Extensible;

our $VERSION = '0.1';

get '/' => sub {
  template 'index';
};

get '/signin' => sub {
  template 'account/signin';
};

# 404 Handler:
any qr{.*} => sub {
  status 'not_found';
  template 'error_docs/404', {
    path => request->path()
  };
};

1;
