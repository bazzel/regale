require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:event).counter_cache(true) }
  end

  describe 'scopes' do
    describe '.default_scope' do
      subject { described_class.all.to_sql }

      it { is_expected.to eq described_class.all.order(:accept_status).to_sql }
    end

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

  describe 'invitation_expired?' do
    subject do
      build :guest do |guest|
        guest.event = build :event, :future, respond_before: respond_before
      end
    end

    context 'no respond_before' do
      let(:respond_before) { nil }

      it { is_expected.not_to be_invitation_expired }
    end

    context 'respond_before passed' do
      let(:respond_before) { 1.day.ago }

      it { is_expected.to be_invitation_expired }
    end

    context 'respond_before not passed' do
      let(:respond_before) { 1.day.from_now }

      it { is_expected.not_to be_invitation_expired }
    end
  end
end
