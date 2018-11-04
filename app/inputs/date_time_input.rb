class DateTimeInput < SimpleForm::Inputs::StringInput
  DATA_ATTRIBUTES = {
    'date-format': I18n.t('datetime.formats.datetimepicker')
  }

  def input(wrapper_options)
    @input_html_options[:data] ||= {}
    @input_html_options[:data].merge!(DATA_ATTRIBUTES)

    super
  end

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
