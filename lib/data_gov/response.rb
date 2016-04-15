module DataGov
  class FuelStation
    include Virtus.model
    attribute :station_name, String
    attribute :street_address, String
    attribute :city, String
    attribute :state, String
    attribute :zip, String
    attribute :ev_network, String
    attribute :id, Integer
  end

  class Response
    include Virtus.model
    attribute :latitude, String
    attribute :longitude, String
    attribute :station_locator_url, String
    attribute :total_results, Integer
    attribute :fuel_stations, Array[FuelStation]
    def find_station(name)
      fuel_stations.find { |station| station.station_name == name }
    end
  end

  class IDResponse
    include Virtus.model
    attribute :alt_fuel_station, FuelStation
  end
end
