require 'spec_helper'

describe "media_vehicles/edit" do
  before(:each) do
    @media_vehicle = assign(:media_vehicle, stub_model(MediaVehicle,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit media_vehicle form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => media_vehicles_path(@media_vehicle), :method => "post" do
      assert_select "input#media_vehicle_name", :name => "media_vehicle[name]"
      assert_select "textarea#media_vehicle_description", :name => "media_vehicle[description]"
    end
  end
end
