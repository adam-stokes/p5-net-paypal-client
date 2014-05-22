package Net::PayPal::Model::Payment;

# ABSTRACT: payment model for paypal

use Mojo::Base 'Net::PayPal::Client';

has endpoint => 'v1/payments/payment';

sub all {
    my $self = shift;
    return $self->get($self->endpoint);
}

1;

__END__
