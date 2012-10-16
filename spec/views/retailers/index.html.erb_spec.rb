require 'spec_helper'

describe "retailers/index" do
  before(:each) do
    assign(:retailers, [
      stub_model(Retailer,
        :name => "Name",
        :sector => "",
        :description => "MyText"
      ),
      stub_model(Retailer,
        :name => "Name",
        :sector => "",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of retailers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
