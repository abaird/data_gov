module DataGov
  class Query
    def initialize(key: nil, **optional_params)
      @optional_params = optional_params
      find_api_key(key)
    end

    def url
      resource_url.to_s +
        build_param_string(@optional_params).to_s +
        "api_key=#{@api_key}"
    end

    private

    def find_api_key(key)
      @api_key = key || ENV['API_KEY']
    end

    def build_param_string(params)
      string = ''
      params.delete_if { |_k, v| v.nil? }.each_pair do |k, v|
        string += "#{k}=#{v}&"
      end
      string
    end
  end

  class NearestStationQuery < Query
    def url
      resource_url.to_s +
        build_param_string(@optional_params).to_s +
        "api_key=#{@api_key}"
    end

    def resource_url
      'https://api.data.gov/nrel/alt-fuel-stations/v1/nearest.json?'
    end
  end

  class StationByIdQuery < Query
    def resource_url
      'https://api.data.gov/nrel/alt-fuel-stations/v1/'
    end

    def url(id)
      resource_url + id + '.json?' +
        build_param_string(@optional_params).to_s +
        "api_key=#{@api_key}"
    end
  end
end
