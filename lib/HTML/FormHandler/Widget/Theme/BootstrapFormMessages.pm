package HTML::FormHandler::Widget::Theme::BootstrapFormMessages;
# ABSTRACT: role to render form messages using Bootstrap styling

use Moose::Role;

=head1 NAME

HTML::FormHandler::Widget::Theme::BootstrapFormMessages

=head1 DESCRIPTION

Role to render form messages using Bootstrap styling.

=cut

sub render_form_messages {
    my ( $self, $result ) = @_;

    $result ||= $self->result;
    my $output = '';
    if ( $result->has_form_errors || $result->has_errors ) {
        $output = qq{\n<div class="alert alert-error">};
        my $msg = $self->error_message;
        $msg ||= 'There were errors in your form';
        $msg = $self->_localize($msg);
        $output .= qq{\n<span class="error_message">$msg</span>};
        $output .= qq{\n<span class="error_message">$_</span>}
            for $result->all_form_errors;
        $output .= "\n</div>";
    }
    elsif ( $result->validated ) {
        my $msg = $self->success_message;
        $msg ||= "Your form was successfully submitted";
        $msg = $self->_localize($msg);
        $output = qq{\n<div class="alert alert-success">};
        $output .= qq{\n<span>$msg</span>};
        $output .= "\n</div>";
    }
    if ( $self->has_info_message && $self->info_message ) {
        my $msg = $self->info_message;
        $msg = $self->_localize($msg);
        $output = qq{\n<div class="alert alert-info">};
        $output .= qq{\n<span>$msg</span>};
        $output .= "\n</div>";
    }
    return $output;
}

1;
