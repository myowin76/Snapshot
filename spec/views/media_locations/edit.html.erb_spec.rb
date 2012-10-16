require 'spec_helper'

describe "media_locations/edit" do
  before(:each) do
    @media_location = assign(:media_location, stub_model(MediaLocation,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit media_location form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => media_locations_path(@media_location), :method => "post" do
      assert_select "input#media_location_name", :name => "media_location[name]"
      assert_select "textarea#media_location_description", :name => "media_location[description]"
    end
  end
end
