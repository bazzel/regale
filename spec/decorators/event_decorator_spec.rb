require 'rails_helper'

RSpec.describe EventDecorator do
  describe '#calendar' do
    subject        { instance.decorate.calendar }
    let(:instance) { build_stubbed :event, scheduled_at: '2004-12-31 13:00:00' }

    it { is_expected.to have_content('Dec') }
    it { is_expected.to match('<strong>31</strong>') }
  end

  describe '#guests_info_item' do
    subject        { instance.decorate.guests_info_item }
    let(:instance) { build_stubbed :event, guests_count: 5 }

    it { is_expected.to have_css('span.fa.fa-users') }
    it { is_expected.to have_content('Guests') }
    it { is_expected.to match('<strong>5</strong>') }
  end
end
