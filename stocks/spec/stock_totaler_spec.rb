require_relative '../stock_totaler'

RSpec.describe "stock totaler" do
  let (:tesla_data) do
    <<-JSON
    {

    }
    JSON
  end

  it "calculates stock share value" do
    total_value = calculate("GOOG", 1)
    expect(total_value).to eq(689.35)
  end
end
