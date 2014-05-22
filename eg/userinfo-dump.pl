#!/usr/bin/env perl

use Mojo::Base -strict;
use Mojo::Log;
use Net::PayPal;
use Net::PayPal::Client;
use DDP;

my $log = Mojo::Log->new;

# Authenticate and grab a access_token
my $pp = Net::PayPal->new(
    'key' => $ENV{PPKEY},
    'secret' => $ENV{PPSECRET},
);

my $access_token = $pp->refresh($ENV{PPREFRESH_TOKEN})->{access_token};

$log->debug("Access token: " .$access_token);

my $c = Net::PayPal::Client->new(
    'access_token' => $access_token
);

my $tx =
  $c->model('Userinfo')->info;

p $tx;
