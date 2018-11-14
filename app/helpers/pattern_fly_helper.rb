# frozen_string_literal: true
require './lib/pattern_fly/icons'
require './lib/pattern_fly/alert'
require './lib/pattern_fly/toast_notification'

module PatternFlyHelper
  def pf_flash(options = {})
    PatternFly::Alert.new(options, self).render
  end

  def pf_toast_notification(options = {})
    PatternFly::ToastNotification.new(options, self).render
  end

  def pf_icon(icon)
    PatternFly::Icons.send(icon)
  end
end
