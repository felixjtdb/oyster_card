require 'station'

describe Station do
  station = Station.new("Aldgate", 1)

  it 'station has a name and zone' do
    expect(station.name).to eq("Aldgate")
  end
  it 'station has a zone' do
    expect(station.zone).to eq(1)
  end
end
