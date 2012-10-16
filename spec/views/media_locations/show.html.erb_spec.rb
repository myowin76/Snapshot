require 'spec_helper'

describe "media_locations/show" do
  before(:each) do
    @media_location = assign(:media_location, stub_model(MediaLocation,
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
