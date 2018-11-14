class AppetizerDecorator < ApplicationDecorator
  delegate_all
  decorates_association :guests
end
