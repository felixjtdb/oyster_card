class Journey
  attr_accessor :entry_station, :exit_station
  MINIMUM = 1
  PENALTY = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def in_journey?
    (!!@entry_station and @exit_station == nil)
  end

  def fare
    (@entry_station == nil or @exit_station == nil) ? PENALTY : MINIMUM
  end
end
