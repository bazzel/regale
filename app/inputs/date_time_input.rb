class DateTimeInput < SimpleForm::Inputs::StringInput
  def input_html_classes
    classname = case input_type
                when :date then 'bootstrap-datepicker'
                when :datetime then 'bootstrap-datetimepicker'
                end

    super.push(classname)
  end

  private

  def string?
    true
  end
end
