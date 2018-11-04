require 'rails_helper'

RSpec.describe EventDecorator do
  describe '#calendar' do
    subject { p instance.decorate.calendar }
    let(:instance) { create :event, scheduled_at: '2004-12-31 13:00:00' }

    it { is_expected.to have_content('Dec') }
    it { is_expected.to match('<strong>31</strong>') }
  end
end
