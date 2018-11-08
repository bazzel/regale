# frozen_string_literal: true

module PatternFlyHelper
  def pf_flash(options = {})
    PatternFly::Alert.new(options, self).render
  end
end
