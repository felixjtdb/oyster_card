class Oyster
  attr_reader :money, :capacity, :min_fare, :entry_station

  def initialize
    @money = 0
    @capacity = 90
    @min_fare = 1
    @entry_station = 0
    @journies = {}
  end

  def top_up(money)
    fail "Maximum credit is #{@capacity}" if (@money + money) > @capacity
    @money += money
  end

  def touch_in(entry_station)
    fail "Not enough money" if @money < @min_fare
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(@min_fare)
    @journies[@entry_station] = exit_station
    @entry_station = 0
  end

  def in_journey?
    @entry_station == 0 ? false : true
  end


  def list_trips
    @journies
  end

  private

  def deduct(fare)
    @money -= fare
  end

end
