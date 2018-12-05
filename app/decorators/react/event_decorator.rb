module React
  class EventDecorator
    attr_reader :event

    def initialize(event)
      @event = event.try(:model) || event
    end

    def as_json(_options = nil)
      to_jbuilder.attributes!
    end

    def to_jbuilder
      Jbuilder.new do |json|
        json.accept_status do |ac|
          event.guests.group(:accept_status).count.each do |accept_status, count|
            ac.set! accept_status, count
          end
        end
      end
    end
  end
end
