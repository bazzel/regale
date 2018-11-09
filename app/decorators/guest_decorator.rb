class GuestDecorator < ApplicationDecorator
  delegate_all
  decorates_association :event

  def dom_id
    h.dom_id(self)
  end

  def respond_buttons
    buttons = self.class.accept_statuses.keys.map { |status| respond_button(status) }
    h.content_tag(:div, class: 'btn-group') do
      h.safe_join(buttons, ' ')
    end
  end

  def accept_status
    I18n.t("accept_status/#{model.accept_status}", scope: [:activerecord, :attributes, :guest])
  end

  def scheduled_at
    I18n.l(event.scheduled_at, format: :date_at_time)
  end

  private

  def respond_button(status)
    name         = I18n.t("accept_status/#{status}", scope: [:helpers, :submit])
    html_options = {
      method: :put,
      params: {
        guest: {
          accept_status: Guest.accept_statuses[status]
        }
      },
      disabled: (model.accept_status == status),
      class: 'btn btn-default',
      remote: true,
      data: {
        disable_with: name
      }
    }

    h.button_to(name, model, html_options)
  end
end
