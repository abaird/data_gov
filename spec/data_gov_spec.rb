require 'spec_helper'

# Query for nearest stations to Austin, TX that are part of the "ChargePoint Network".
# Verify that "HYATT AUSTIN" appears in the results. Store/save the Station Id of the HYATT AUSTIN
# station.

# Use the Station ID from previous test to query the API and return the Street Address of that
# station.
# Verify the Station Address is 208 Barton Springs, Austin, Texas, USA, 78704

describe DataGov do
  it 'should the address of the Hyatt Austin station' do
    args = { location: 'Austin+TX', ev_network: 'ChargePoint Network' }
    get DataGov::NearestStationQuery.new(args).url
    resp = DataGov::Response.new(json_body)
    expect(response.code).to eq 200
    id = resp.find_station('HYATT AUSTIN').id
    expect(id).to be_an(Integer)

    get DataGov::StationByIdQuery.new.url(id.to_s)
    resp = DataGov::IDResponse.new(json_body)
    expect(response.code).to eq 200
    expect(resp.alt_fuel_station.street_address).to eq '208 Barton Springs Rd'
    expect(resp.alt_fuel_station.city).to eq 'Austin'
    expect(resp.alt_fuel_station.state).to eq 'TX'
    expect(resp.alt_fuel_station.zip).to eq '78704'
  end
end
