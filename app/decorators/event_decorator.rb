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
    content = [scheduled_at.strftime('%b')]
    content << h.content_tag(:strong, scheduled_at.strftime('%-d'))

    h.safe_join content
  end

end
