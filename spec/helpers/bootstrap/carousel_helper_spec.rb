require 'rails_helper'

RSpec.describe Bootstrap::CarouselHelper, type: :helper do
  describe '#bs_carousel' do
    subject          { helper.bs_carousel(collection) { 'Lorem' }}
    let(:collection) { [1,2] }

    it { is_expected.to have_css('.carousel.slide[data-ride="carousel"]') }

    describe 'indicators' do
      it { is_expected.to have_css('.carousel ol.carousel-indicators') }

      it 'marks the first as active' do
        expect(subject).to have_css('.carousel-indicators li:first.active')
      end

      it 'renders an indicator for every element and targets the container' do
        expect(subject).to have_css('.carousel-indicators li[data-target^="#"]', count: collection.size)
      end

      it 'assigns a counter to every indicator' do
        collection.each_with_index do |e, i|
          expect(subject).to have_css(".carousel-indicators li[data-slide-to='#{i}']")
        end
      end
    end

    describe 'wrapper for slides' do
      it { is_expected.to have_css('.carousel .carousel-inner') }

      it 'wraps every slide' do
        expect(subject).to have_css('.carousel-inner .item', count: collection.size)
      end

      it 'marks the first slide as active' do
        expect(subject).to have_css('.carousel-inner .item:first.active')
      end

      it 'renders every element' do
        expect(subject).to have_css('.carousel-inner .item', text: 'Lorem', count: collection.size)
      end
    end

    describe 'controls' do
      it 'renders a Previous button' do
        expect(subject).to have_css('.carousel a.left.carousel-control[href^="#"][data-slide="prev"]')
        expect(subject).to have_css('.carousel a.left span.fa.fa-chevron-left')
      end

      it 'renders a Next button' do
        expect(subject).to have_css('.carousel a.right.carousel-control[href^="#"][data-slide="next"]')
        expect(subject).to have_css('.carousel a.right span.fa.fa-chevron-right')
      end
    end

    describe 'collection has 1 element' do
      let(:collection) { [1] }

      it { is_expected.to have_no_css('.carousel') }

      it 'renders the element' do
        expect(subject).to have_content('Lorem')
      end
    end

    describe 'collection is empty' do
      let(:collection) { [] }
      it { is_expected.to be_nil }
    end
  end
end
