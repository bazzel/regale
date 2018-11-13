require 'rails_helper'

RSpec.describe GuestDecorator do
  describe '#respond_buttons' do
    subject        { instance.decorate.respond_buttons }

    let(:instance) { build_stubbed :guest, id: 42 }

    describe 'buttons' do
      it do
        expect(subject).to have_css('.btn-group form[action="/guests/42"][data-remote="true"]', count: 3)
        expect(subject).to have_css('.btn-group form input.btn.btn-default', count: 3)
        expect(subject).to have_css('.btn-group form input[name="_method"][value="put"]', visible: false, count: 3)
        expect(subject).not_to have_css('.btn-group form input[disabled="disabled"]')
      end
    end

    describe 'Accept button' do
      it do
        expect(subject).to have_css('.btn-group form input[value="Accept"][data-disable-with="Accept"]')
        expect(subject).to have_css('.btn-group form input[name="guest[accept_status]"][value=0]', visible: false)
      end
    end

    describe 'Decline button' do
      it do
        expect(subject).to have_css('.btn-group form input[value="Decline"][data-disable-with="Decline"]')
        expect(subject).to have_css('.btn-group form input[name="guest[accept_status]"][value=1]', visible: false)
      end
    end

    describe 'Maybe button' do
      it do
        expect(subject).to have_css('.btn-group form input[value="Maybe"][data-disable-with="Maybe"]')
        expect(subject).to have_css('.btn-group form input[name="guest[accept_status]"][value=2]', visible: false)
      end
    end

    describe 'guest accepted' do
      let(:instance) { build_stubbed :guest, accept_status: Guest.accept_statuses[:yes] }

      it do
        expect(subject).to have_css('.btn-group form input[value="Accept"][disabled="disabled"]')
        expect(subject).to have_css('.btn-group form input[disabled="disabled"]', count: 1)
      end
    end

    describe 'guest declined' do
      let(:instance) { build_stubbed :guest, accept_status: Guest.accept_statuses[:no] }

      it do
        expect(subject).to have_css('.btn-group form input[value="Decline"][disabled="disabled"]')
        expect(subject).to have_css('.btn-group form input[disabled="disabled"]', count: 1)
      end
    end

    describe 'guest said maybe' do
      let(:instance) { build_stubbed :guest, accept_status: Guest.accept_statuses[:maybe] }

      it do
        expect(subject).to have_css('.btn-group form input[value="Maybe"][disabled="disabled"]')
        expect(subject).to have_css('.btn-group form input[disabled="disabled"]', count: 1)
      end
    end
  end

  describe 'bootstrap-select collections' do
    let(:el1)      { double('Element', id: 1, title: 'foo', description: 'Lorem') }
    let(:el2)      { double('Element', id: 2, title: 'bar', description: 'Ipsum') }
    let(:instance) { build_stubbed :guest }

    describe '#soup_collection' do
      before         { allow(instance.event).to receive(:soups).and_return([el1, el2]) }
      subject        { instance.decorate.soup_collection }

      it { is_expected.to include(['foo', 1, data: { subtext: 'Lorem' }]) }
      it { is_expected.to include(['bar', 2, data: { subtext: 'Ipsum' }]) }
    end

    describe '#appetizer_collection' do
      before         { allow(instance.event).to receive(:appetizers).and_return([el1, el2]) }
      subject        { instance.decorate.appetizer_collection }

      it { is_expected.to include(['foo', 1, data: { subtext: 'Lorem' }]) }
      it { is_expected.to include(['bar', 2, data: { subtext: 'Ipsum' }]) }
    end

    describe '#main_course_collection' do
      before         { allow(instance.event).to receive(:main_courses).and_return([el1, el2]) }
      subject        { instance.decorate.main_course_collection }

      it { is_expected.to include(['foo', 1, data: { subtext: 'Lorem' }]) }
      it { is_expected.to include(['bar', 2, data: { subtext: 'Ipsum' }]) }
    end

    describe '#dessert_collection' do
      before         { allow(instance.event).to receive(:desserts).and_return([el1, el2]) }
      subject        { instance.decorate.dessert_collection }

      it { is_expected.to include(['foo', 1, data: { subtext: 'Lorem' }]) }
      it { is_expected.to include(['bar', 2, data: { subtext: 'Ipsum' }]) }
    end
  end
end
