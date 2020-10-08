require_relative '../lib/dark_trader'

describe "the darktrader_array method" do
  it "should return an array" do
    expect(darktrader_master).to be_instance_of Array
  end
  it "should not be nil" do
    expect(darktrader_master).not_to be_nil
  end
end