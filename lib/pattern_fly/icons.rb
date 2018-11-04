# frozen_string_literal: true

module PatternFly
  class Icons
    extend ActionView::Helpers::TagHelper

    PF_ICONS = {
      ok: 'ok',
      info: 'info',
      warning: 'warning-triangle-o',
      error: 'error-circle-o'
    }.freeze

    class << self
      PF_ICONS.each do |k, v|
        define_method(k) do
          content_tag(:span, '', class: "pficon pficon-#{v}")
        end
      end
    end
  end
end
