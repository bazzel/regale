module Bootstrap
  module Carousel
    class Indicators
      delegate :capture, :content_tag, :concat, to: :@template
      attr_reader :items, :template, :uid

      def initialize(items, template, uid)
        @items    = items
        @template = template
        @uid      = uid
      end

      def render
        indicators_wrapper do
          items.count.times { |i| concat indicator(i) }
        end
      end

      private

      def indicators_wrapper
        content_tag(:ol, class: 'carousel-indicators') { yield }
      end

      def indicator(i)
        options = {
          data: {
            target: "##{uid}",
            'slide-to': i
          }
        }
        options.merge!(class: 'active') if i.zero?

        content_tag(:li, '', options)
      end
    end
  end
end
