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
    let(:instance) { build_stubbed :guest}

    describe '#soup_collection' do
      before         { allow(instance.event).to receive(:soups).and_return([el1, el2]) }
      subject        { instance.decorate.soup_collection }
      let(:el1)      { build(:soup, id: 1, title: 'foo', description: 'Lorem') }
      let(:el2)      { build(:soup, id: 2, title: 'bar', description: 'Ipsum') }

      it { is_expected.to include(['foo', 1, data: { subtext: 'Lorem' }]) }
      it { is_expected.to include(['bar', 2, data: { subtext: 'Ipsum' }]) }
    end

    describe '#appetizer_collection' do
      before         { allow(instance.event).to receive(:appetizers).and_return([el1, el2]) }
      subject        { instance.decorate.appetizer_collection }
      let(:el1)      { build(:appetizer, id: 1, title: 'foo', description: 'Lorem') }
      let(:el2)      { build(:appetizer, id: 2, title: 'bar', description: 'Ipsum') }

      it { is_expected.to include(['foo', 1, data: { subtext: 'Lorem' }]) }
      it { is_expected.to include(['bar', 2, data: { subtext: 'Ipsum' }]) }
    end

    describe '#main_course_collection' do
      before         { allow(instance.event).to receive(:main_courses).and_return([el1, el2]) }
      subject        { instance.decorate.main_course_collection }
      let(:el1)      { build(:main_course, id: 1, title: 'foo', description: 'Lorem') }
      let(:el2)      { build(:main_course, id: 2, title: 'bar', description: 'Ipsum') }

      it { is_expected.to include(['foo', 1, data: { subtext: 'Lorem' }]) }
      it { is_expected.to include(['bar', 2, data: { subtext: 'Ipsum' }]) }
    end

    describe '#dessert_collection' do
      before         { allow(instance.event).to receive(:desserts).and_return([el1, el2]) }
      subject        { instance.decorate.dessert_collection }
      let(:el1)      { build(:dessert, id: 1, title: 'foo', description: 'Lorem') }
      let(:el2)      { build(:dessert, id: 2, title: 'bar', description: 'Ipsum') }

      it { is_expected.to include(['foo', 1, data: { subtext: 'Lorem' }]) }
      it { is_expected.to include(['bar', 2, data: { subtext: 'Ipsum' }]) }
    end
  end

  describe '#with_visual_accept' do
    before         { allow(instance).to receive_message_chain(:user, :to_label) { 'Marty' } }
    subject        { p instance.with_visual_accept }

    context 'yes' do
      let(:instance) { build_stubbed(:guest, :yes).decorate }

      it { is_expected.to have_css('.accept-status.yes span.pficon.pficon-ok[data-toggle="tooltip"][title="Accepted"]') }
      it { is_expected.to have_css('.accept-status.yes span.guest-name[data-toggle="tooltip"][title="Marty"]', text: 'Marty') }
    end

    context 'no' do
      let(:instance) { build_stubbed(:guest, :no).decorate }

      it { is_expected.to have_css('.accept-status.no span.pficon.pficon-error-circle-o[data-toggle="tooltip"][title="Declined"]') }
      it { is_expected.to have_css('.accept-status.no span.guest-name[data-toggle="tooltip"][title="Marty"]', text: 'Marty') }
    end

    context 'maybe' do
      let(:instance) { build_stubbed(:guest, :maybe).decorate }

      it { is_expected.to have_css('.accept-status.maybe span.pficon.pficon-unknown[data-toggle="tooltip"][title="Maybe"]') }
      it { is_expected.to have_css('.accept-status.maybe span.guest-name[data-toggle="tooltip"][title="Marty"]', text: 'Marty') }
    end

    context 'not responded' do
      let(:instance) { build_stubbed(:guest).decorate }

      it { is_expected.not_to have_css('.accept-status span.pficon') }
      it { is_expected.to have_css('.accept-status span.guest-name[data-toggle="tooltip"][title="Marty"]', text: 'Marty') }
    end
  end
end
