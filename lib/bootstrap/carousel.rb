module Bootstrap
  class Carousel
    delegate :capture,
      :content_tag,
      :concat,
      :link_to,
      :safe_join, to: :@template
    attr_reader :items, :template, :block

    def initialize(items, template, &block)
      @items = items
      @template = template
      @block = block
    end

    def render
      return if items.empty?

      carousel
    end

    private

    def uid
      @uid ||= SecureRandom.hex(6)
    end

    def partial(item)
      capture { block.call(item) }
    end

    def carousel
      return partial(items.first) if items.one?

      options = {
        id: uid,
        class: 'carousel slide',
        data: {
          ride: 'carousel'
        }
      }

      content_tag(:div, options) do
        concat indicators
        concat inner
        concat controls
      end
    end

    def indicators
      items_count = items.count

      indicators_wrapper do
        items_count.times { |i| concat indicator(i) }
      end
    end

    def indicators_wrapper
      content_tag(:ol, class: 'carousel-indicators') { yield }
    end

    def indicator(index)
      options = {
        data: {
          target: "##{uid}",
          'slide-to': index
        }
      }
      options.merge!(class: 'active') if index.zero?

      content_tag(:li, '', options)
    end

    def inner
      content_tag(:div, class: 'carousel-inner') do
        items.each_with_index do |element, i|
          options = {
            class: 'item'
          }
          options[:class] << ' active' if i.zero?
          concat content_tag(:div, partial(i), options)
        end
      end
    end

    def controls
      safe_join [control_left, control_right]
    end

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
