class HasFeedbackStringInput < SimpleForm::Inputs::StringInput

  def input(wrapper_options = nil)
    super + feedback_label
  end

  private
  def feedback_label
    object.send(attribute_name)&.feedback_label(class: 'form-control-feedback')
  end
end
