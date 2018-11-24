require 'rails_helper'

RSpec.describe FontAwesomeHelper, type: :helper do
  describe '#fa_icon' do
    subject { helper.fa_icon('lorem') }

    it { is_expected.to have_css('span.fa.fa-lorem') }

    context 'with options passed' do
      subject { helper.fa_icon('lorem', class: 'fa-2x', title: 'ipsum') }

      it { is_expected.to have_css('span.fa.fa-lorem.fa-2x[title="ipsum"]') }
    end
  end
end
