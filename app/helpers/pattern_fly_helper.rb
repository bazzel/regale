# frozen_string_literal: true

require './lib/pattern_fly/alert'

module PatternFlyHelper
  def pf_flash(options = {})
    PatternFly::Alert.new(options, self).render
  end
end
