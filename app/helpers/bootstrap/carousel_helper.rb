require './lib/bootstrap/carousel/renderer'

module Bootstrap
  module CarouselHelper
    def bs_carousel(collection, &block)
      Bootstrap::Carousel::Renderer.render(collection, self, &block)
    end
  end
end
