require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:event).counter_cache(true) }
  end

  describe 'scopes' do
    describe '.upcoming' do
      subject { described_class.upcoming }

      let!(:past_event)     { create :event_with_guests, scheduled_at: Date.yesterday, guests_count: 1 }
      let!(:today_event)    { create :event_with_guests, scheduled_at: Chronic.parse('today noon'), guests_count: 2 }
      let!(:tomorrow_event) { create :event_with_guests, scheduled_at: Date.tomorrow, guests_count: 3 }
      let!(:far_away_event) { create :event_with_guests, scheduled_at: 10.days.from_now, guests_count: 4 }

      it { expect(subject.count).to eq(9) }
    end

    describe '.for_user' do
      subject { described_class.for_user(me) }

      let(:me) { create :user, name: 'me' }
      let(:other) { create :user, name: 'other' }
      let(:with_me) do
        create :event do |e|
          e.users << me
        end
      end
      let(:without_me) do
        create :event do |e|
          e.users << other
        end
      end

      it { is_expected.to contain_exactly(*with_me.guests) }
    end
  end
end
