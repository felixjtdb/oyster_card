require 'journey'
require 'oyster_card'

describe Journey do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station  }

  it 'a new journey has no entry station' do
    expect(subject.entry_station).to eq nil
  end
  it 'a new journey has no exit station' do
    expect(subject.exit_station).to eq nil
  end
  describe '#fare' do
    it 'expects minimum fare for completed journey' do
      card = Oystercard.new(10)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.current.fare).to eq Journey::MINIMUM
    end
    it 'expects penalty fare if no exit station' do
      card = Oystercard.new(10)
      card.touch_in(entry_station)
      expect(card.current.fare).to eq Journey::PENALTY
    end
    it 'expects penalty fare if no entry station' do
      card = Oystercard.new(10)
      card.touch_out(exit_station)
      expect(card.current.fare).to eq Journey::PENALTY
    end
  end
end
