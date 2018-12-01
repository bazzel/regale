class DishDecorator < ApplicationDecorator
  delegate_all
  decorates_association :guests

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def title_with_icon
    h.safe_join([vegetarian_icon, title].compact, ' ')
  end

  def vegetarian_icon(options = {})
    vegetarian? ? h.fa_icon('leaf', options) : nil
  end

end
