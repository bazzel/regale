require 'rails_helper'

RSpec.describe UserDecorator do
  describe '#to_label' do
    subject        { instance.decorate.to_label }

    context 'without name' do
      let(:instance) { build_stubbed :user, email: 'john.doe@example.com' }

      it { is_expected.to eql('john.doe@example.com') }
    end

    context 'without name' do
      let(:instance) { build_stubbed :user, name: 'John', email: 'john.doe@example.com' }

      it { is_expected.to eql('John') }
    end
  end

  describe '#to_s' do
    subject        { instance.decorate.to_s }

    context 'without name' do
      let(:instance) { build_stubbed :user, email: 'john.doe@example.com' }

      it { is_expected.to eql('john.doe@example.com') }
    end

    context 'without name' do
      let(:instance) { build_stubbed :user, name: 'John', email: 'john.doe@example.com' }

      it { is_expected.to eql('John') }
    end
  end

  describe '#destroy_link' do
    subject { instance.decorate.destroy_link }

    let(:instance) { build_stubbed :user, id: 1, name: 'John' }

    context 'other user' do
      it do
        expect(subject).to have_css('a.btn.btn-danger[data-confirm^="Are you sure"][data-method="delete"][href="/users/1"]', text: 'Delete')
      end
    end

    context 'myself' do
      before { allow(h).to receive(:current_user).and_return(instance) }

      it do
        expect(subject).to have_css('a.btn.btn-danger.disabled[href="#"]', text: 'Delete')
      end
    end
  end
end
