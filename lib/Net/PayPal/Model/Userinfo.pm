package Net::PayPal::Model::Userinfo;

# ABSTRACT: userinfo model for paypal

use Mojo::Base 'Net::PayPal::Client';

has endpoint => 'v1/identity/openidconnect/userinfo/';

sub info {
    my $self = shift;
    $self->params->{schema} = 'openid';
    return $self->get($self->endpoint);
}

1;

__END__
