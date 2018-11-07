require './lib/bootstrap/carousel'

module Bootstrap
  module CarouselHelper
    def bs_carousel(collection, &block)
      Bootstrap::Carousel.new(collection, self, &block).render
    end
  end
end
