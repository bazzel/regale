class SoupDecorator < ApplicationDecorator
  delegate_all
  decorates_association :guests
end
