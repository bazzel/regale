class EventDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def calendar
    h.capture do
      h.concat scheduled_at.strftime('%b')
      h.concat h.content_tag(:strong, scheduled_at.strftime('%d'))
    end
  end

  def guests_info_item
    h.content_tag(:div, class: 'list-view-pf-additional-info-item') do
      h.concat h.fa_icon('users')
      h.concat h.content_tag(:strong, guests_count)
      h.concat Guest.model_name.human(count: guests_count)
    end
  end

  def courses_info_item
    h.content_tag(:div, class: 'list-view-pf-additional-info-item') do
      h.concat h.fa_icon('cutlery')
      h.concat h.content_tag(:strong, courses_count)
      h.concat Course.model_name.human(count: courses_count)
    end
  end

  def dishes_info_item
    h.content_tag(:div, class: 'list-view-pf-additional-info-item') do
      h.concat h.fa_icon('spoon')
      h.concat h.content_tag(:strong, dishes.count)
      h.concat Dish.model_name.human(count: dishes.count)
    end
  end

end
