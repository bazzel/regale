class EventDecorator < ApplicationDecorator
  delegate_all

  decorates_association :guests

  Dish.courses.each do |d|
    name = d.model_name.plural.to_sym
    decorates_association name
  end

  def calendar
    h.capture do
      h.concat scheduled_at.strftime('%b')
      h.concat h.content_tag(:strong, scheduled_at.strftime('%d'))
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

  def dishes_info_item
    info_item_wrapper do
      h.concat h.fa_icon('spoon')
      h.concat h.content_tag(:strong, dishes.count)
      h.concat Dish.model_name.human(count: dishes.count)
    end
  end

  def guests_summary
    # WARNING: n+1 query alert
    scope  = %i(events event guests_summary)
    guests = model.guests

    [
      I18n.t(:yes, scope: scope, count: guests.yes.count),
      I18n.t(:no, scope: scope, count: guests.no.count),
      I18n.t(:maybe, scope: scope, count: guests.maybe.count),
      I18n.t(:awaiting, scope: scope, count: guests.where(accept_status: nil).count)
    ].reject { |e| e.blank? }.to_sentence
  end

  def map_link_url
    return location unless location && latitude && longitude

    h.link_to location, Geocoder::Lookup.get(:google).map_link_url(coordinates),  target: '_blank'
  end

  private

  def info_item_wrapper
    h.content_tag(:div, class: 'list-view-pf-additional-info-item') do
      yield
    end
  end
end
