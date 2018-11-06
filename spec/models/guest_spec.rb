require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:event).counter_cache(true) }
  end
end
