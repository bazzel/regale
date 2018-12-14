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
        json.accept_statuses_summary event.accept_statuses_summary
      end
    end
  end
end
