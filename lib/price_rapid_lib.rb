require "uri"
require "net/http"

class PriceRapidLib
  def initialize
    @api_base = ENV["RAPID_API_BASE"]
    @api_host = ENV["RAPID_API_HOST"]
    @api_key = ENV["RAPID_API_KEY"]
  end

  def get_price_all
    get_data
  end

  def get_prices(args)
    get_data.select do |item|
      args.include?(item["identifier"])
    end
  end

  def get_price(arg)
    get_data.find { |item| item["identifier"] == arg }
  end

  private

  def get_data
    url = URI(@api_base)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = @api_key
    request["x-rapidapi-host"] = @api_host

    response = http.request(request)
    json_data = JSON.parse(response.read_body)
    json_data
  end
end
