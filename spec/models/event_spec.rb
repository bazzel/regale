require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(100) }
    it { is_expected.to validate_presence_of(:scheduled_at) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:guests) }
    it { is_expected.to have_many(:users).through(:guests) }
  end

  describe 'scopes' do

    describe '.upcoming' do
      subject { described_class.upcoming }

      let!(:past) { create :event, scheduled_at: Date.yesterday }
      let!(:today) { create :event, scheduled_at: Chronic.parse('today noon') }
      let!(:tomorrow) { create :event, scheduled_at: Date.tomorrow }
      let!(:far_away) { create :event, scheduled_at: 10.days.from_now }

      it { is_expected.to contain_exactly(today, tomorrow, far_away) }
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

      it { is_expected.to contain_exactly(with_me) }
    end
  end


  describe '#scheduled_at' do

  end
end
