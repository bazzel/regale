class EventDecorator < ApplicationDecorator
  delegate_all

  decorates_association :guests

  Dish.courses.each do |d|
    name = d.model_name.plural.to_sym
    decorates_association name
  end

  def to_s
    title.inspect
  end

  def scheduled_at
    I18n.l(model.scheduled_at, format: :medium)
  end

  def respond_before
    return unless model.respond_before

    I18n.l(model.respond_before, format: :medium)
  end

  def calendar
    h.capture do
      h.concat model.scheduled_at.strftime('%b')
      h.concat h.content_tag(:strong, model.scheduled_at.strftime('%d'))
    end
  end

  def guests_info_item
    info_item_wrapper do
      h.content_tag(:div, class: 'list-view-pf-expand') do
        h.concat h.fa_icon('angle-right')
        h.concat h.fa_icon('users')
        h.concat h.content_tag(:strong, guests_count)
        h.concat Guest.model_name.human(count: guests_count)
      end
    end
  end

  def courses_info_item
    x = 0
    x += 1 if soups.any?
    x += 1 if appetizers.any?
    x += 1 if main_courses.any?
    x += 1 if desserts.any?

    info_item_wrapper do
      h.content_tag(:div, class: 'list-view-pf-expand') do
        h.concat h.fa_icon('angle-right')
        h.concat h.fa_icon('cutlery')
        h.concat h.content_tag(:strong, x)
        h.concat I18n.t('activerecord.models.course', count: x)
      end
    end
  end

  def donut_info_item
    h.content_tag(:div, class: 'list-view-pf-additional-info-item list-view-pf-additional-info-item-donut-chart') do
      h.content_tag(:div, class: 'list-view-pf-expand') do
        h.react_component("DonutChart", React::EventDecorator.new(model))
      end
    end
  end

  def dishes_info_item
    info_item_wrapper do
      h.concat h.fa_icon('spoon')
      h.concat h.content_tag(:strong, dishes.count)
      h.concat Dish.model_name.human(count: dishes.count)
    end
  end

  def link_to_location
    return location unless shareable_location?

    h.link_to location, Geocoder::Lookup.get(:google).map_link_url(model.coordinates),  target: '_blank'
  end

  def shareable_location?
    location && coordinates.all?
  end

  def truncated_additional_info_with_tooltip
    return if additional_info.blank?

    tooltip = h.pf_icon('info', h.tooltipped(h.simple_format(additional_info), data: { html: true }))

    h.truncate(h.content_tag(:p, additional_info), escape: false, length: 100) { h.safe_join [' ', tooltip] }
  end

  private

  def info_item_wrapper
    h.content_tag(:div, class: 'list-view-pf-additional-info-item') do
      yield
    end
  end
end
