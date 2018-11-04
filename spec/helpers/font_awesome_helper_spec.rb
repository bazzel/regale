require 'rails_helper'

RSpec.describe FontAwesomeHelper, type: :helper do
  describe '#fa_icon' do
    subject { helper.fa_icon('lorem') }

    it { is_expected.to have_css('span.fa.fa-lorem') }
  end
end
