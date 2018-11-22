module FontAwesome
  class Icons
    class << self
      include ActionView::Helpers::TagHelper

      def method_missing(method_name, *arguments)
        options = arguments.extract_options!
        options[:class] ||= ''
        options[:class] << " fa fa-#{method_name}"
        content_tag(:span, '', options)
      end
    end
  end
end
