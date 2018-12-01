module ButtonsHelper
  def add_event_button
    link_to t('helpers.submit.add_resource', resource: Event.model_name.human), new_event_path, class: 'btn btn-primary btn-lg'
  end

  def add_user_button
    link_to t('helpers.submit.add_resource', resource: User.model_name.human), new_user_path, class: 'btn btn-primary btn-lg'
  end
end
