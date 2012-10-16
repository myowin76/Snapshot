require 'spec_helper'

describe "media_vehicles/show" do
  before(:each) do
    @media_vehicle = assign(:media_vehicle, stub_model(MediaVehicle,
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
