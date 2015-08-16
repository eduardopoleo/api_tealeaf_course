require "json"
require "faraday"

class SymbolNotFound < StandardError; end

def calculate(symbol, quantity)
  url = "http://dev.markitondemand.com/Api/v2/Quote/json"

  http_client = Faraday.new

  response = http_client.get(url, symbol: symbol)

  data = JSON.load(response.body)
  price = data["LastPrice"]
  raise SymbolNotFound.new(data["Message"]) unless price

  total = price.to_f * quantity.to_i
  #JSON.pretty_generate(JSON(response.body)) to get a prettyfy response 
end

symbol, quantity = ARGV
puts calculate(symbol, quantity) if $0 == __FILE__ 
