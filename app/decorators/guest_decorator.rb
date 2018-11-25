class GuestDecorator < ApplicationDecorator
  delegate_all
  decorates_association :event
  decorates_association :user

  def dom_id
    h.dom_id(self)
  end

  def respond_buttons
    buttons = self.class.accept_statuses.keys.map { |status| respond_button(status) }
    h.content_tag(:div, class: 'btn-group') do
      h.safe_join(buttons, ' ')
    end
  end

  def accept_status_word
    I18n.t("accept_status/#{accept_status}", scope: [:activerecord, :attributes, :guest])
  end

  def with_visual_accept
    content = [
      accept_status_icon,
      h.content_tag(:span, user.to_label, class: 'guest-name', title: user.to_label, data: { toggle: :tooltip })
    ]

    h.safe_join(content, ' ')
  end

  def accept_status_icon(options={})
    icon = 'ok'             if yes?
    icon = 'error'          if no?
    icon = 'unknown status' if maybe?
    h.pf_icon(icon, options.merge(title: accept_status_word, data: { toggle: :tooltip })) if icon
  end

  def soup_collection
    bootstrap_select_collection(event.soups)
  end

  def appetizer_collection
    bootstrap_select_collection(event.appetizers)
  end

  def main_course_collection
    bootstrap_select_collection(event.main_courses)
  end

  def dessert_collection
    bootstrap_select_collection(event.desserts)
  end

  private

  def bootstrap_select_collection(collection)
    collection.map { |d| [d.title, d.id, { data: { subtext: d.description }}] }
  end

  def respond_button(status)
    name         = I18n.t("accept_status/#{status}", scope: [:helpers, :submit])
    html_options = {
      method: :put,
      params: {
        guest: {
          accept_status: Guest.accept_statuses[status]
        }
      },
      disabled: (accept_status == status),
      class: 'btn btn-default',
      remote: true,
      data: {
        disable_with: name
      }
    }

    h.button_to(name, model, html_options)
  end
end
