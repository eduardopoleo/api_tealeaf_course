require "json"
require "faraday"

def calculate(symbol, quantity)
  url = "http://dev.markitondemand.com/Api/v2/Quote/json"

  http_client = Faraday.new
  response = http_client.get(url, symbol: symbol)
  data = JSON.load(response.body)

  price = data["LastPrice"]
  total = price.to_f * quantity.to_i
  #JSON.pretty_generate(JSON(response.body)) to get a prettyfy response 
end

calculate("TSLA", 2)

# symbol, quantity = ARGV
# puts total if $0 == __FILE__
