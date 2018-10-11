require 'oyster_card'
require 'station'
require 'pry'
describe Oystercard do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station  }

  it 'has a balance' do
    expect(subject.balance).to eq 0
  end

  it 'increases balance by top up value' do
    card = Oystercard.new
    card.top_up(30)
    expect(card.balance).to eq 30
  end

  it 'has a limit of £90' do
    card = Oystercard.new(90)
    expect { card.top_up(10) }.to raise_error "Unable to top up, maximum #{Oystercard::LIMIT}"
  end

  it "raises an error if balance exceeds limit" do
    card = Oystercard.new
    expect { card.top_up(100) }.to raise_error "Unable to top up, maximum #{Oystercard::LIMIT}"
  end

  it 'deducts an amount from balance' do
    card = Oystercard.new(10)
    card.deduct(5)
    expect(card.balance).to eq 5
  end

  it 'should not be in_journey before touching in' do
    card = Oystercard.new
    expect(card.current.in_journey?).to eq false
  end

  it 'should be in_jouney when touching in' do
    card = Oystercard.new(5)
    card.touch_in(entry_station)
    expect(card.current.in_journey?).to eq true
  end

  it 'should be in_jouney when touching in' do
    card = Oystercard.new(2)
    card.touch_in(entry_station)
    card.touch_out(exit_station)
    expect(card.current.in_journey?).to eq false
  end

  it 'raises an error if there is an insufficient balance upon touch_in (£1)' do
    card = Oystercard.new
    expect { card.touch_in(entry_station) }.to raise_error "Insufficient funds - less then #{Oystercard::MINIMUM}"
  end

  it "should reduce the balance by minimum fare when touching out" do
    card = Oystercard.new(2)
    card.touch_in(entry_station)
    expect { card.touch_out(exit_station) }.to change { card.balance }.by(-Oystercard::MINIMUM)
  end

  it 'stores a journey' do
    card = Oystercard.new(10)
    card.touch_in(entry_station)
    card.touch_out(exit_station)
    expect(card.journeys).to eq ([card.current])
  end
end
