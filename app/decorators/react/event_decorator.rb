module React
  class EventDecorator
    attr_reader :event

    def initialize(event)
      @event = event
    end

    def as_json(_options = nil)
      to_jbuilder.attributes!
    end

    def to_jbuilder
      Jbuilder.new do |json|
        event.guests.group(:accept_status).count.each do |accept_status, count|
          json.set! (accept_status || 'awaiting'), count
        end
      end
    end
  end
end
