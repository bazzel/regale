class GuestDecorator < ApplicationDecorator
  delegate_all
  decorates_association :event

  def dom_id
    h.dom_id(self)
  end
end
