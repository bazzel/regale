module Bootstrap
  module Carousel
    class Renderer
      delegate :capture, :content_tag, :concat, :link_to, :safe_join, to: :@template
      attr_reader :items, :template, :uid, :inner, :indicators, :controls, :block

      def self.render(*args, &block)
        new(*args, &block).render
      end

      def initialize(items, template, &block)
        @items      = items
        @template   = template
        @block      = block
        @uid        = SecureRandom.hex(6)
        @indicators = Indicators.new(items, template, uid)
        @inner      = Inner.new(items, template, block)
        @controls   = Controls.new(template, uid)
      end

      def render
        return                            if items.empty?
        return inner.partial(items.first) if items.one?

        carousel
      end

      private

      def carousel
        content_tag(:div, options) do
          concat indicators.render
          concat inner.render
          concat controls.render
        end
      end

      def options
        {
          id: uid,
          class: 'carousel slide',
          data: {
            ride: 'carousel'
          }
        }
      end
    end
  end
end
