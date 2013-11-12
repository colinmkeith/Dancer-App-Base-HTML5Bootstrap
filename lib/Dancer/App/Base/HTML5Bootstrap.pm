package Dancer::App::Base::HTML5Bootstrap;
use Dancer ':syntax';

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

true;
