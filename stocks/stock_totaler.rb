require "json"
require "faraday"

def calculate(symbol, quantity)
  url = "http://dev.markitondemand.com/Api/v2/Quote/json"

  http_client = Faraday.new
  response = http_client.get(url, symbol: symbol)
  data = JSON.load(response.body)

  price = data["LastPrice"]
  total = price.to_f * quantity.to_i
  puts response.body
end

calculate("TSLA", 1)

# symbol, quantity = ARGV
# puts total if $0 == __FILE__
