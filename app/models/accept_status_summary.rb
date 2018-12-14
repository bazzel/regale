class AcceptStatusSummary < HashWithIndifferentAccess
  attr_reader :guests

  def initialize(guests)
    @guests = guests
    set_defaults
    super
  end

  # @return [HashWithIndifferentAccess] contains all accept statuses (`nil` included) as keys
  #   and the number of corresponding responses asthe values
  # @example
  #   event = Event.find(43)
  #   AcceptStatusSummary.new(event.guests).summary
  #   # => {
  #          yes: 13,
  #          no:  2,
  #          maybe: 3,
  #          nil => 34
  #        }
  def summary
    accept_statuses_count.each do |accept_status, count|
      self[accept_status] = count
    end

    self
  end

  private

  def set_defaults
    accept_statuses_keys.each { |k| self[k] = 0 }
  end

  def accept_statuses_keys
    Guest.accept_statuses.keys.push(nil)
  end

  def accept_statuses_count
    @accept_statuses_count ||= guests.group(:accept_status).count
  end
end
