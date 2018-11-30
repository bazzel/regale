require 'rails_helper'

RSpec.describe UserPolicy do
  let(:record) { build_stubbed :user }
  let(:user) { build_stubbed :user, :admin }

  subject { described_class.new user, record }

  describe '#permitted_attributes' do
    context 'admin' do
      let(:user)            { build_stubbed :user, :admin }
      let(:expected_attributes) { %i(email name role) }

      it do
        expect(subject.permitted_attributes).to eql(expected_attributes)
      end
    end

    context 'guest' do
      let(:user)            { build_stubbed :user, :guest }
      let(:expected_attributes) { %i(email name) }

      it do
        expect(subject.permitted_attributes).to eql(expected_attributes)
      end
    end
  end
  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
