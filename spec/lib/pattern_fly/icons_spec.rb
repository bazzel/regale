require 'rails_helper'

RSpec.describe PatternFly::Icons do
  describe '.ok' do
    subject { Capybara.string described_class.ok }

    it { is_expected.to have_css('span.pficon.pficon-ok') }
  end

  describe '.info' do
    subject { Capybara.string described_class.info }

    it { is_expected.to have_css('span.pficon.pficon-info') }
  end

  describe '.warning' do
    subject { Capybara.string described_class.warning }

    it { is_expected.to have_css('span.pficon.pficon-warning-triangle-o') }
  end

  describe '.error' do
    subject { Capybara.string described_class.error }

    it { is_expected.to have_css('span.pficon.pficon-error-circle-o') }
  end
end
