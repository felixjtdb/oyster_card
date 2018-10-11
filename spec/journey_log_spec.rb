require 'journey_log'
describe JourneyLog do
  let(:station) { instance_double("Station", name: "Liverpool st", zone: 1) }
  let(:journey) { instance_double("Journey", entry_station: "Bank", entry_station: "Angel" ) }

  describe "#start" do
    it "start creates a new Journey instance with a entry station" do
      subject.start(station)
      expect(subject.journey.entry_station).to eq(station)
    end
    it "start creates a new Journey instance with a entry station" do
      subject.start(station)
      expect(subject.logged_journies).to include journey
    end
  describe "#" do
    
  end
  end
end
