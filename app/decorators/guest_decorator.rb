class GuestDecorator < ApplicationDecorator
  delegate_all

  def dom_id
    h.dom_id(self)
  end
end
