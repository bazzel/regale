module BsCarouselHelper

  def bs_carousel(collection, &block)
    if collection.size == 1
      yield(collection.first) and return
    end

    content_tag(:div, id: uid, class: 'carousel slide', data: { ride: 'carousel' }) do
      concat indicators(collection.size)
      concat inner(collection, &block)
      concat controls
    end
  end

  def uid
    @uid ||= SecureRandom.hex(6)
  end

  def indicators(count)
    content_tag(:ol, class: 'carousel-indicators') do
      count.times do |i|
        options = {
          data: {
            target: uid,
            'slide-to': i
          }
        }
        options.merge!(class: 'active') if i.zero?

        concat content_tag(:li, '', options)
      end
    end
  end

  def inner(collection)
    content_tag(:div, class: 'carousel-inner') do
      collection.each_with_index do |element, i|
        partial = capture { yield(element) }
        options = {
          class: 'item'
        }
        options[:class] << ' active' if i.zero?
        concat content_tag(:div, partial, options)
      end
    end
  end

  def controls
    safe_join [control_left, control_right]
  end

  def control_left
    link_to("##{uid}", class: 'left carousel-control', data: { slide: 'prev' }) do
      concat content_tag(:span, '', class: 'glyphicon glyphicon-chevron-left')
      concat content_tag(:div, 'Previous', class: 'sr-only')
    end
  end

  def control_right
    link_to("##{uid}", class: 'right carousel-control', data: { slide: 'next' }) do
      concat content_tag(:span, '', class: 'glyphicon glyphicon-chevron-right')
      concat content_tag(:div, 'Next', class: 'sr-only')
    end
  end
end

