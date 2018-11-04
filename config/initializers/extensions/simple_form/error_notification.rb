require Rails.root.join 'lib/pattern_fly/icons'

module PatternFlyStuff
  def translate_error_notification
    PatternFly::Icons.error + super
  end
end

SimpleForm::ErrorNotification.prepend(PatternFlyStuff)
