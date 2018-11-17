# frozen_string_literal: true

module PatternFly
  class Icons
    extend ActionView::Helpers::TagHelper

    PF_ICONS = {
      ok: 'ok',
      info: 'info',
      warning: 'warning-triangle-o',
      error: 'error-circle-o',
      close: 'close',
      'unknown status': 'unknown'

    }.freeze

    class << self
      PF_ICONS.each do |k, v|
        define_method(k) do |options = {}|
          default_class   = "pficon pficon-#{v}"
          options[:class] = [options[:class], default_class].join(' ')

          content_tag(:span, '', options)
        end
      end
    end
  end
end
