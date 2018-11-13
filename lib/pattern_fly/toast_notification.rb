# frozen_string_literal: true

module PatternFly
  # See: https://www.patternfly.org/pattern-library/communication/toast-notifications/
  class ToastNotification < Alert
    protected

    def default_tag_class
      'toast-pf toast-pf-max-width toast-pf-top-right alert-dismissable'
    end
  end
end
