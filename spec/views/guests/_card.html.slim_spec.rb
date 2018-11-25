require 'rails_helper'

RSpec.describe "guests/card", type: :view do
  let(:event) do
    build :event, :future, {
      respond_before: respond_before,
      location: location
    }
  end

  let(:guest) do
    create(:guest, {
      accept_status: accept_status,
      event: event
    }).decorate
  end
  let(:respond_before) { 1.day.from_now }
  let(:accept_status) { nil }
  let(:location) { 'New York, NY' }

  subject do
    render partial: "guests/card", object: guest, as: :guest
    rendered
  end

  it { is_expected.to have_css('.guest-card') }
  it { is_expected.to have_css('.guest-card .card-pf-heading .card-pf-title', text: event.title) }

  context 'invitation not expired' do
    it { is_expected.to have_css('.guest-card .card-pf-heading .card-pf-heading-details .btn-group') } # Rest is tested in the decorator

    context 'accept status' do
      context 'not accepted yet' do
        it { is_expected.not_to have_css('.guest-card.yes') }
        it { is_expected.not_to have_css('.guest-card.no') }
        it { is_expected.not_to have_css('.guest-card.maybe') }
      end

      context 'yes' do
        let(:accept_status) { Guest.accept_statuses[:yes] }

        it { is_expected.to have_css('.guest-card.yes') }
      end

      context 'no' do
        let(:accept_status) { Guest.accept_statuses[:no] }

        it { is_expected.to have_css('.guest-card.no') }
      end

      context 'maybe' do
        let(:accept_status) { Guest.accept_statuses[:maybe] }

        it { is_expected.to have_css('.guest-card.maybe') }
      end
    end

    context 'respond before' do
      describe 'present' do
        it { is_expected.to have_css('.guest-card .card-pf-body .card-pf-aggregate-status-notifications .card-pf-aggregate-status-notification span.fa.fa-calendar-check-o') }
        it { is_expected.to have_css('.guest-card .card-pf-body .card-pf-aggregate-status-notifications .card-pf-aggregate-status-notification', text: guest.event.respond_before) }
      end

      describe 'not present' do
        let(:respond_before) { nil }

        it { is_expected.not_to have_css('.guest-card .card-pf-body .card-pf-aggregate-status-notifications .card-pf-aggregate-status-notification span.fa.fa-calendar-check-o') }
      end
    end

    context 'location' do
      describe 'present' do
        it { is_expected.to have_css('.guest-card .card-pf-body .card-pf-aggregate-status-notifications .card-pf-aggregate-status-notification span.fa.fa-map-marker') }
        it { is_expected.to have_css('.guest-card .card-pf-body .card-pf-aggregate-status-notifications .card-pf-aggregate-status-notification', text: location) }
      end

      describe 'not present' do
        let(:location) { nil }
        it { is_expected.not_to have_css('.guest-card .card-pf-body .card-pf-aggregate-status-notifications .card-pf-aggregate-status-notification span.fa.fa-map-marker') }
      end
    end

    context 'menu' do
      before do
        allow(event).to receive(:soups).and_return(build_list(:soup, 0))
        allow(event).to receive(:appetizers).and_return(build_list(:appetizer, 1))
        allow(event).to receive(:main_courses).and_return(build_list(:main_course, 2))
        allow(event).to receive(:desserts).and_return(build_list(:dessert, 3))
      end

      it { is_expected.to have_css('.guest-card form .card-pf-body .card-pf-subtitle', text: 'Create your own menu') }
      it { is_expected.not_to have_css('.guest-card form .card-pf-body .form-group.select', text: 'Soup') }
      it { is_expected.to have_css('.guest-card form .card-pf-body .form-group.select', text: 'Appetizer') }
      it { is_expected.to have_css('.guest-card form .card-pf-body .form-group.select', text: 'Main Course') }
      it { is_expected.to have_css('.guest-card form .card-pf-body .form-group.select', text: 'Dessert') }
      it { is_expected.to have_css('.guest-card form .card-pf-footer input[type="submit"][value="Submit Menu"]') }
    end
  end

  context 'invitation expired' do
    let(:respond_before) { 1.day.ago }

    it { is_expected.not_to have_css('.guest-card .card-pf-heading .btn-group') } # Rest is tested in the decorator

    context 'accept status' do
      context 'not accepted' do
        it { is_expected.not_to have_css('.guest-card.yes') }
        it { is_expected.not_to have_css('.guest-card.no') }
        it { is_expected.not_to have_css('.guest-card.maybe') }

        it { is_expected.to have_css('.guest-card .card-pf-heading .card-pf-heading-details span.fa-ban') }
      end

      context 'yes' do
        let(:accept_status) { Guest.accept_statuses[:yes] }

        it { is_expected.to have_css('.guest-card .card-pf-heading .card-pf-heading-details span.pficon-ok') }
      end

      context 'no' do
        let(:accept_status) { Guest.accept_statuses[:no] }

        it { is_expected.to have_css('.guest-card .card-pf-heading .card-pf-heading-details span.pficon-error-circle-o') }
      end

      context 'maybe' do
        let(:accept_status) { Guest.accept_statuses[:maybe] }

        it { is_expected.to have_css('.guest-card .card-pf-heading .card-pf-heading-details span.pficon-unknown') }
      end
    end

    context 'location' do
      describe 'present' do
        it { is_expected.to have_css('.guest-card .card-pf-body .card-pf-aggregate-status-notifications .card-pf-aggregate-status-notification span.fa.fa-map-marker') }
        it { is_expected.to have_css('.guest-card .card-pf-body .card-pf-aggregate-status-notifications .card-pf-aggregate-status-notification', text: location) }
      end

      describe 'not present' do
        let(:location) { nil }
        it { is_expected.not_to have_css('.guest-card .card-pf-body .card-pf-aggregate-status-notifications .card-pf-aggregate-status-notification span.fa.fa-map-marker') }
      end
    end

    context 'menu' do
      before do
        allow(event).to receive(:soups).and_return(build_list(:soup, 0))
        allow(event).to receive(:appetizers).and_return(build_list(:appetizer, 1))
        allow(event).to receive(:main_courses).and_return(build_list(:main_course, 2))
        allow(event).to receive(:desserts).and_return(build_list(:dessert, 3))

        allow(guest).to receive(:appetizer).and_return(appetizer)
        allow(guest).to receive(:main_course).and_return(main_course)
        allow(guest).to receive(:dessert).and_return(nil)
      end

      let(:appetizer) { build_stubbed :appetizer, title: 'my-appetizer' }
      let(:main_course) { build_stubbed :main_course, title: 'my-main-course' }

      it { is_expected.to have_css('.guest-card form .card-pf-body .card-pf-subtitle', text: 'This will be your menu') }

      it { is_expected.not_to have_css('.guest-card form .card-pf-body .form-group.readonly', text: 'Soup') }
      it { is_expected.to have_css('.guest-card form .card-pf-body .form-group.readonly', text: 'Appetizer') }
      it { is_expected.to have_css('.guest-card form .card-pf-body .form-group.readonly', text: 'Main Course') }
      it { is_expected.to have_css('.guest-card form .card-pf-body .form-group.readonly', text: 'Dessert') }
      it { is_expected.not_to have_css('.guest-card form .card-pf-footer input[type="submit"][value="Submit Menu"]') }

      it { is_expected.to have_css('.guest-card form .card-pf-body .form-group.readonly input[readonly="readonly"][value="my-appetizer"]') }
      it { is_expected.to have_css('.guest-card form .card-pf-body .form-group.readonly input[readonly="readonly"][value="my-main-course"]') }
    end
  end
end
