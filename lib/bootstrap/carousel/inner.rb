module Bootstrap
  module Carousel
    class Inner
      delegate :capture, :content_tag, :concat, to: :@template
      attr_reader :items, :template, :block

      def initialize(items, template, block)
        @items    = items
        @template = template
        @block    = block
      end

      def render
        content_tag(:div, class: 'carousel-inner') do
          items.each_with_index do |element, i|
            options = {
              class: 'item'
            }
            options[:class] << ' active' if i.zero?
            concat content_tag(:div, partial(element), options)
          end
        end
      end

      def partial(item)
        capture { block.call(item) }
      end
    end
  end
end

