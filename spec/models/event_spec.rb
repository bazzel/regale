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

  describe '#scheduled_at' do

  end
end
