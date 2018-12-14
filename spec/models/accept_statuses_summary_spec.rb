require 'rails_helper'

RSpec.describe AcceptStatusesSummary, type: :model do
  describe '#summary' do
    subject { instance.summary }

    let(:instance) { described_class.new(event.guests) }
    let(:event) { create :event }

    context 'all guests responded' do
      before do
        event.guests << build_list(:guest, 1, :yes)
        event.guests << build_list(:guest, 2, :no)
        event.guests << build_list(:guest, 3, :maybe)
      end

      it { is_expected.to include(yes: 1) }
      it { is_expected.to include(no: 2) }
      it { is_expected.to include(maybe: 3) }
      it { is_expected.to include(nil => 0) }
    end

    context 'no "yes"' do
      before do
        event.guests << build_list(:guest, 1)
        event.guests << build_list(:guest, 2, :no)
        event.guests << build_list(:guest, 3, :maybe)
      end

      it { is_expected.to include(yes: 0) }
      it { is_expected.to include(no: 2) }
      it { is_expected.to include(maybe: 3) }
      it { is_expected.to include(nil => 1) }
    end

    context 'no "no"' do
      before do
        event.guests << build_list(:guest, 1, :yes)
        event.guests << build_list(:guest, 2)
        event.guests << build_list(:guest, 3, :maybe)
      end

      it { is_expected.to include(yes: 1) }
      it { is_expected.to include(no: 0) }
      it { is_expected.to include(maybe: 3) }
      it { is_expected.to include(nil => 2) }
    end

    context 'no "maybe"' do
      before do
        event.guests << build_list(:guest, 1, :yes)
        event.guests << build_list(:guest, 2, :no)
        event.guests << build_list(:guest, 3)
      end

      it { is_expected.to include(yes: 1) }
      it { is_expected.to include(no: 2) }
      it { is_expected.to include(maybe: 0) }
      it { is_expected.to include(nil => 3) }
    end
  end

  describe '#to_sentence' do
    subject { instance.to_sentence }
    let(:instance) { described_class.new(event.guests) }
    let(:event) do
      create :event do |event|
        event.guests << yes
        event.guests << no
        event.guests << maybe
        event.guests << awaiting
      end
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
end
