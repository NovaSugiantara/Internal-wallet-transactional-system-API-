# lib/latest_stock_price.rb
require 'net/http'
require 'json'

class LatestStockPrice
  BASE_URL = 'https://rapidapi.com/suneetk92/api/latest-stock-price'

  def self.price(symbol)
    uri = URI("#{BASE_URL}/price/#{symbol}")
    response = fetch(uri)
    parse_response(response)
  end

  def self.prices(symbols)
    uri = URI("#{BASE_URL}/prices/#{symbols.join(',')}")
    response = fetch(uri)
    parse_response(response)
  end

  def self.price_all
    uri = URI("#{BASE_URL}/price_all")
    response = fetch(uri)
    parse_response(response)
  end

  private

  def self.fetch(uri)
    response = Net::HTTP.get_response(uri)

    unless response.is_a?(Net::HTTPSuccess)
      raise StandardError, "Failed to fetch data from #{uri}"
    end

    response.body
  end

  def self.parse_response(response)
    JSON.parse(response)
  rescue JSON::ParserError
    raise StandardError, 'Failed to parse response JSON'
  end
end
