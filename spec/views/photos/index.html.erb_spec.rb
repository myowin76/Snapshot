require 'spec_helper'

describe "photos/index" do
  before(:each) do
    assign(:photos, [
      stub_model(Photo,
        :brand => nil,
        :audit => nil,
        :category => nil,
        :media_location => nil,
        :media_vehicle => nil,
        :media_type => nil,
        :description => "MyText"
      ),
      stub_model(Photo,
        :brand => nil,
        :audit => nil,
        :category => nil,
        :media_location => nil,
        :media_vehicle => nil,
        :media_type => nil,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of photos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
