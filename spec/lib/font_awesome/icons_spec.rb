require 'rails_helper'

require Rails.root.join('lib/font_awesome/icons')

RSpec.describe FontAwesome::Icons do
  describe '.lorem' do
    subject { Capybara.string described_class.lorem }

    it { is_expected.to have_css('span.fa.fa-lorem') }
  end
end
