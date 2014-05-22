package Net::PayPal::Client;

# ABSTRACT: PayPal REST client for perl

use Mojo::Base -base;
use Mojo::UserAgent;
use Mojo::JSON;
use Mojo::URL;
use Mojo::Log;
use Module::Runtime qw(use_module);
use DDP;

has 'access_token';
has 'use_sandbox' => 1;
has 'log' => sub {
  my $self = shift;
  return Mojo::Log->new;
};

has 'api_host' => sub {
  my $self = shift;
  if ($self->use_sandbox) {
    'https://api.sandbox.paypal.com';
  } else {
    'https://api.paypal.com';
  }
};

has 'params' => sub {
    my $self = shift;
    return +{};
};

has 'json' => sub {
    my $self = shift;
    my $json = Mojo::JSON->new;
    return $json;
};

has 'ua' => sub {
    my $self = shift;
    my $ua = Mojo::UserAgent->new;
    $ua->transactor->name("Net::PayPal/1.0");
    return $ua;
};

sub get {
    my ($self, $path) = @_;
    my $url =
      Mojo::URL->new($self->api_host)->path($path)->query($self->params);
    $self->log->debug(sprintf("GET %s ", $url->to_string));
    my $tx =
      $self->ua->get(
        $url->to_string => {Authorization => "Bearer " . $self->access_token}
      );
    return $self->json->decode($tx->res->body);
}

sub post {
    my ($self, $path) = @_;
    my $url = Mojo::URL->new($self->api_host)->path($path);
    my $tx =
      $self->ua->post($url->to_string =>
          {Authorization => "Bearer " . $self->access_token} => form =>
          $self->params);
    return $self->json->decode($tx->res->body);
}

sub model {
  my ($self, $class) = @_;
  my $model = "Net::PayPal::Model::$class";
  return use_module($model)->new($self);
}

1;
