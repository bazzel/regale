class EventDecorator < ApplicationDecorator
  delegate_all

  def calendar
    h.capture do
      h.concat scheduled_at.strftime('%b')
      h.concat h.content_tag(:strong, scheduled_at.strftime('%d'))
    end
  end

  def guests_info_item
    info_item_wrapper do
      h.concat h.fa_icon('users')
      h.concat h.content_tag(:strong, guests_count)
      h.concat Guest.model_name.human(count: guests_count)
    end
  end

  def courses_info_item
    info_item_wrapper do
      h.concat h.fa_icon('cutlery')
      h.concat h.content_tag(:strong, courses_count)
      h.concat Course.model_name.human(count: courses_count)
    end
  end

  def dishes_info_item
    info_item_wrapper do
      h.concat h.fa_icon('spoon')
      h.concat h.content_tag(:strong, dishes.count)
      h.concat Dish.model_name.human(count: dishes.count)
    end
  end

  private

  def info_item_wrapper
    h.content_tag(:div, class: 'list-view-pf-additional-info-item') do
      yield
    end
  end
end
