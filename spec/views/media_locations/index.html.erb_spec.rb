require 'spec_helper'

describe "media_locations/index" do
  before(:each) do
    assign(:media_locations, [
      stub_model(MediaLocation,
        :name => "Name",
        :description => "MyText"
      ),
      stub_model(MediaLocation,
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of media_locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
