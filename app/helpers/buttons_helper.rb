module ButtonsHelper
  def add_event_button
    add_resource_button(Event, new_event_path)
  end

  def add_user_button
    add_resource_button(User, new_user_path)
  end

  private
  def add_resource_button(resource, url)
    link_to t('helpers.submit.add_resource', resource: resource.model_name.human), url, class: 'btn btn-primary btn-lg'
  end
end
