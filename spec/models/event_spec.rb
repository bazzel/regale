require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(100) }
    it { is_expected.to validate_presence_of(:scheduled_at) }
    it { is_expected.to validate_length_of(:location).is_at_most(255) }
    it { is_expected.to validate_length_of(:additional_info).is_at_most(500) }

    describe 'respond_before' do
      subject        { instance }
      let(:instance) { build :event, scheduled_at: Date.today, respond_before: Date.tomorrow }

      it { is_expected.to be_invalid }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:guests).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:guests) }
    it { is_expected.to have_many(:dishes).dependent(:destroy) }
    it { is_expected.to have_many(:soups).dependent(:destroy) }
    it { is_expected.to have_many(:appetizers).dependent(:destroy) }
    it { is_expected.to have_many(:main_courses).dependent(:destroy) }
    it { is_expected.to have_many(:desserts).dependent(:destroy) }
  end

  describe 'nested_attributes' do
    it { is_expected.to accept_nested_attributes_for(:soups).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:appetizers).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:main_courses).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:desserts).allow_destroy(true) }
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

  describe '#invitation_expired?' do
    subject { build :event, :future, respond_before: respond_before }

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

  describe 'geocoding' do
    let(:instance) { build :event, location: location }
    let(:location) { 'New York, NY' }
    let(:lat)      { 40.7143528 }
    let(:long)     { -74.0059731 }

    it do
      expect do
        instance.save
      end.to change { instance.latitude }.to(lat).and \
      change { instance.longitude }.to(long)
    end

    describe '#coordinates' do
      subject { instance.coordinates }
      before do
        allow(instance).to receive(:latitude).and_return(lat)
        allow(instance).to receive(:longitude).and_return(long)
      end

      it { is_expected.to eql([lat, long]) }
    end
  end

  describe '#accept_status_summary', focus: true do
    subject { instance.accept_statuses_summary }

    let(:instance) { create :event }

    context 'all guests responded' do
      before do
        instance.guests << build_list(:guest, 1, :yes)
        instance.guests << build_list(:guest, 2, :no)
        instance.guests << build_list(:guest, 3, :maybe)
      end

      it { is_expected.to include(yes: 1) }
      it { is_expected.to include(no: 2) }
      it { is_expected.to include(maybe: 3) }
      it { is_expected.to include(nil => 0) }
    end

    context 'no "yes"' do
      before do
        instance.guests << build_list(:guest, 1)
        instance.guests << build_list(:guest, 2, :no)
        instance.guests << build_list(:guest, 3, :maybe)
      end

      it { is_expected.to include(yes: 0) }
      it { is_expected.to include(no: 2) }
      it { is_expected.to include(maybe: 3) }
      it { is_expected.to include(nil => 1) }
    end

    context 'no "no"' do
      before do
        instance.guests << build_list(:guest, 1, :yes)
        instance.guests << build_list(:guest, 2)
        instance.guests << build_list(:guest, 3, :maybe)
      end

      it { is_expected.to include(yes: 1) }
      it { is_expected.to include(no: 0) }
      it { is_expected.to include(maybe: 3) }
      it { is_expected.to include(nil => 2) }
    end

    context 'no "maybe"' do
      before do
        instance.guests << build_list(:guest, 1, :yes)
        instance.guests << build_list(:guest, 2, :no)
        instance.guests << build_list(:guest, 3)
      end

      it { is_expected.to include(yes: 1) }
      it { is_expected.to include(no: 2) }
      it { is_expected.to include(maybe: 0) }
      it { is_expected.to include(nil => 3) }
    end
  end

  describe '#scheduled_at' do

  end
end
