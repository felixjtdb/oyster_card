require_relative 'journey'
class JourneyLog
  attr_reader :journey, :logged_journies
  def initialize
    @journey = Journey.new
    @logged_journies = []
  end

  def start(entry_station)
    @journey.entry_station = entry_station
    @logged_journies.push(@journey)
  end

  
end
