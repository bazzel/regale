require 'rails_helper'

RSpec.describe Soup, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:guests).dependent(:nullify) }
  end
end
