require_relative '../stock_totaler'

require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassetes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end

RSpec.describe "stock totaler" do
  it "calculates stock share value", :vcr do
    total_value = calculate("TSLA", 1)
    expect(total_value).to eq(243.16)
  end

  it "handles invalid stock symbol", :vcr do
    expect(->{
      calculate("ZZZZ", 1) 
    }).to raise_error(SymbolNotFound, /No symbol matches/)
  end
end
