require 'spec_helper'

describe "stores/index" do
  before(:each) do
    assign(:stores, [
      stub_model(Store,
        :name => "Name",
        :address => "Address",
        :address2 => "Address2",
        :postcode => "Postcode",
        :store_format => "",
        :retailer => "",
        :longitude => 1.5,
        :latitude => 1.5,
        :description => "MyText"
      ),
      stub_model(Store,
        :name => "Name",
        :address => "Address",
        :address2 => "Address2",
        :postcode => "Postcode",
        :store_format => "",
        :retailer => "",
        :longitude => 1.5,
        :latitude => 1.5,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of stores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Address2".to_s, :count => 2
    assert_select "tr>td", :text => "Postcode".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
