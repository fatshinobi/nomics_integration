require 'json'
require 'uri'
require 'net/http'
require 'net/https'

class ApiRequest
  def process
    api_url_url = "https://api.nomics.com/v1/#{api_type}?key=#{key}#{api_params}"
    uri = URI.parse(api_url_url)

    request = Net::HTTP::Get.new(uri) do |http|
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    raise StandardError.new "The response is not success: #{response.body}" unless response.code == '200'

    map_to_model JSON.parse(response.body)
  end

  def api_type
    raise NotImplementedError.new 'api_type should be implemented'
  end

  def api_params
    raise NotImplementedError.new 'api_params should be implamented'
  end

  def map_to_model(json_input)
    result = []

    json_input.each do |json_record|
      model_inst = new_model_instance
      model_inst.from_json(json_record.to_json)
      result << model_inst
    end
    result
  end

  def new_model_instance
    raise NotImplementedError.new 'new_model_instance should be implemented'
  end

  def key
    'set_your_api_key_here'
  end
end