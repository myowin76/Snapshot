require 'spec_helper'

describe "retailers/show" do
  before(:each) do
    @retailer = assign(:retailer, stub_model(Retailer,
      :name => "Name",
      :sector => "",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(//)
    rendered.should match(/MyText/)
  end
end
