require_relative '../stock_totaler'
require 'webmock/rspec'

RSpec.describe "stock totaler" do
  let (:tesla_data) do
    <<-JSON
    {
      "Status": "SUCCESS",
      "Name": "Tesla Motors Inc",
      "Symbol": "TSLA",
      "LastPrice": 243.16,
      "Change": 0.650000000000006,
      "ChangePercent": 0.268030184322298,
      "Timestamp": "Fri Aug 14 15:59:00 UTC-04:00 2015",
      "MSDate": 42230.6659722222,
      "MarketCap": 30915848720,
      "Volume": 192960,
      "ChangeYTD": 222.41,
      "ChangePercentYTD": 9.3296164740794,
      "High": 247.3,
      "Low": 241.8,
      "Open": 247.3
    }
    JSON
  end

  it "calculates stock share value" do
    url = "http://dev.markitondemand.com/Api/v2/Quote/json?symbol=TSLA"
    stub_request(:get, url).to_return(body: tesla_data)

    total_value = calculate("TSLA", 1)
    expect(total_value).to eq(243.16)
  end
end
