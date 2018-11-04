module FontAwesome
  class Icons
    class << self
      include ActionView::Helpers::TagHelper

      def method_missing(method_name, *arguments)
        content_tag(:span, '', class: "fa fa-#{method_name}")
      end
    end
  end
end
