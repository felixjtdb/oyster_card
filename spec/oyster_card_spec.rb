require 'oyster_card.rb'
describe Oyster do
  let(:entry_station)  { double(:station)}
  it "money is 0 when oyster card is created" do
    expect(subject.money).to eq 0
  end

  describe '#top_up' do
    it "takes 5 and adds it to the oystercards money store" do
      subject.top_up(5)
      expect(subject.money).to eq 5
    end
    it "takes 20 and adds it to the oystercards money store" do
      2.times {subject.top_up(20)}
      expect(subject.money).to eq 40
    end
    it "money is not allowed to be greater than £90" do
      expect{subject.top_up(91)}.to raise_error "Maximum credit is #{subject.capacity}"
    end
    it "cannot top up past £90" do
      subject.top_up(89)
      expect{subject.top_up(2)}.to raise_error "Maximum credit is #{subject.capacity}"
    end
  end

  describe "#touch_in" do
    it "touching in changes status of in_journey to true" do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end
    it "doesn't allow journey if money is less than min_balance" do
      expect{subject.touch_in(entry_station)}.to raise_error 'Not enough money'
    end
    it "remembers station where we touched in" do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
  end
  describe "#touch_out" do
    it "touching out changes status of in_journey to false" do
      subject.top_up(1)
      subject.touch_in(entry_station)
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
    it "takes minimum fare away from balance when touching out" do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect {subject.touch_out}.to change{subject.money}.by(-subject.min_fare)
    end
  end
end
