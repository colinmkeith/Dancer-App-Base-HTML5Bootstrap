#!/usr/bin/env perl

use strict;
use warnings;

use Plack::Builder;
use Dancer ':syntax';
use Dancer::Handler;
use lib 'lib';
use Cwd qw(realpath);

my $appName = 'Dancer::App::Base::HTML5Bootstrap';
my $onDotCloud = -d '/home/dotcloud/';
my $appdir = $onDotCloud ? '/home/dotcloud/current' : Cwd::realpath('.');

my $app1 = sub {
  my $env = shift;
  # ==== Change ENV here

  load_app $appName => {
  };
  setting appdir => $appdir;
  setting views => 'views';

  Dancer::App->set_running_app($appName);
  Dancer::Handler->init_request_headers($env);
  my $req = Dancer::Request->new(env => $env);
  return Dancer->dance($req);
};
builder {
  mount "/" => builder {
    # enable '+$appName::Middleware';
    enable 'Session' => (store => 'File');
    enable 'Debug'   => (panels => [ qw(DBITrace Memory Timer) ]);
    enable 'ConditionalGET';
    enable 'ETag' => (
      file_etag                  => ['mtime size'],
      cache_control              => [ 'must-revalidate', 'max-age=3600' ],
      check_last_modified_header => 1
    );

    # Avoid Deflating for older versions of Netscape
    enable sub {
      my $app = shift;
      sub {
        my $env = shift;
        my $ua = $env->{HTTP_USER_AGENT} || '';
        # Netscape has some problem
        $env->{"psgix.compress-only-text/html"} = 1 if $ua =~ m!^Mozilla/4!;
        # Netscape 4.06-4.08 have some more problems
        $env->{"psgix.no-compress"} = 1 if $ua =~ m!^Mozilla/4\.0[678]!;
        # MSIE (7|8) masquerades as Netscape, but it is fine
        if ( $ua =~ m!\bMSIE (?:7|8)! ) {
          $env->{"psgix.no-compress"} = 0;
          $env->{"psgix.compress-only-text/html"} = 0;
        }
        $app->($env);
      }
    };

    enable "Deflater" => (
      content_type => ['text/css','text/html','text/javascript','application/javascript'],
      vary_user_agent => 1
    );


    $app1;
  };
};
