package Net::PayPal::Model::Invoice;

# ABSTRACT: Invoice model for paypal

use Mojo::Base 'Net::PayPal::Client';

has endpoint => 'v1/invoicing/invoices';

sub all {
    my $self = shift;
    $self->params->{total_count_required} = 'true';
    return $self->get($self->endpoint);
}

1;

__END__
