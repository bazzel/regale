module Bootstrap
  module Carousel
    class Controls
      delegate :content_tag, :concat, :link_to, :safe_join, to: :@template
      attr_reader :uid, :template

      def initialize(template, uid)
        @template = template
        @uid      = uid
      end

      def render
        safe_join [control_left, control_right]
      end

      private

      def control_left
        link_to("##{uid}", class: 'left carousel-control', data: { slide: 'prev' }) do
          concat content_tag(:span, '', class: 'fa fa-chevron-left')
          concat content_tag(:div, 'Previous', class: 'sr-only')
        end
      end

      def control_right
        link_to("##{uid}", class: 'right carousel-control', data: { slide: 'next' }) do
          concat content_tag(:span, '', class: 'fa fa-chevron-right')
          concat content_tag(:div, 'Next', class: 'sr-only')
        end
      end

    end

  end
end
