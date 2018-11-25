require 'rails_helper'

RSpec.describe EventDecorator do
  describe '#calendar' do
    subject        { instance.decorate.calendar }
    let(:instance) { build_stubbed :event, scheduled_at: '2004-12-31 13:00:00' }

    it { is_expected.to have_content('Dec') }
    it { is_expected.to match('<strong>31</strong>') }
  end

  describe '#guests_info_item' do
    subject        { instance.decorate.guests_info_item }
    let(:instance) { build_stubbed :event, guests_count: 5 }

    it { is_expected.to have_css('.list-view-pf-additional-info-item') }
    it { is_expected.to have_css('span.fa.fa-users') }
    it { is_expected.to have_content('Guests') }
    it { is_expected.to match('<strong>5</strong>') }
  end

  describe '#courses_info_item' do
    before do
      allow(instance).to receive(:soups).and_return(build_list(:soup, 0))
      allow(instance).to receive(:appetizers).and_return(build_list(:appetizer, 1))
      allow(instance).to receive(:main_courses).and_return(build_list(:main_course, 2))
      allow(instance).to receive(:desserts).and_return(build_list(:dessert, 3))
    end
    subject        { instance.decorate.courses_info_item }
    let(:instance) { build_stubbed :event }

    it { is_expected.to have_css('.list-view-pf-additional-info-item') }
    it { is_expected.to have_css('span.fa.fa-cutlery') }
    it { is_expected.to have_content('Courses') }
    it { is_expected.to match('<strong>3</strong>') }
  end

  describe '#dishes_info_item' do
    before         { allow(instance).to receive(:dishes).and_return(double('Dish', count: 5)) }
    subject        { instance.decorate.dishes_info_item }
    let(:instance) { build_stubbed :event }

    it { is_expected.to have_css('.list-view-pf-additional-info-item') }
    it { is_expected.to have_css('span.fa.fa-spoon') }
    it { is_expected.to have_content('Dishes') }
    it { is_expected.to match('<strong>5</strong>') }
  end

  describe '#guests_summary' do
    subject { instance.guests_summary }
    let(:instance) do
      create :event do |event|
        event.guests << yes
        event.guests << no
        event.guests << maybe
        event.guests << awaiting
      end.decorate
    end

    let(:yes_count)      { 4 }
    let(:no_count)       { 3 }
    let(:maybe_count)    { 2 }
    let(:awaiting_count) { 1 }
    let(:yes)      { build_list :guest, yes_count, :yes }
    let(:no)       { build_list :guest, no_count, :no }
    let(:maybe)    { build_list :guest, maybe_count, :maybe }
    let(:awaiting) { build_list :guest, awaiting_count }

    context do
      it { is_expected.to eql('4 yes, 3 no, 2 maybe, and 1 awaiting') }
    end

    context do
      let(:yes_count) { 0 }

      it { is_expected.to eql('3 no, 2 maybe, and 1 awaiting') }
    end

    context do
      let(:no_count) { 0 }

      it { is_expected.to eql('4 yes, 2 maybe, and 1 awaiting') }
    end

    context do
      let(:maybe_count) { 0 }

      it { is_expected.to eql('4 yes, 3 no, and 1 awaiting') }
    end

    context do
      let(:awaiting_count) { 0 }

      it { is_expected.to eql('4 yes, 3 no, and 2 maybe') }
    end
  end

  describe '#link_to_location' do
    before { Geocoder.configure(lookup: :test) }

    subject { instance.decorate.link_to_location }
    let(:instance) { create :event, location: location }
    let(:location) { 'New York, NY' }
    let(:lat)      { 40.7143528 }
    let(:long)     { -74.0059731 }

    context 'no coordinates' do
      before { Geocoder::Lookup::Test.add_stub(location, []) }

      it do
        expect(Geocoder::Lookup.get(:google)).not_to receive(:map_link_url)
        expect(subject).to eql(location)
      end
    end

    context 'coordinates' do
      before do
        Geocoder::Lookup::Test.add_stub(location, [{latitude: lat, longitude: long}])
      end

      it do
        expect(Geocoder::Lookup.get(:google)).to receive(:map_link_url).with(instance.coordinates).and_return('http://regale.com')
        expect(subject).to have_css('a[href="http://regale.com"][target="_blank"]')
      end
    end
  end
end
