require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :current, :journeys

  LIMIT = 90
  MINIMUM = 1

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
    @current = Journey.new
  end

  def top_up(amount)
    raise "Unable to top up, maximum #{LIMIT}" if @balance + amount >= LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(entry_station)
    raise "Insufficient funds - less then #{MINIMUM}" if @balance < MINIMUM
    @current = Journey.new
    @current.entry_station = entry_station
  end

  def touch_out(exit_station)
    @current.exit_station = exit_station
    @journeys.push(current)
    @balance -= @current.fare
  end

end
