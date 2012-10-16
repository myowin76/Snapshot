require 'spec_helper'

describe "stores/edit" do
  before(:each) do
    @store = assign(:store, stub_model(Store,
      :name => "MyString",
      :address => "MyString",
      :address2 => "MyString",
      :postcode => "MyString",
      :store_format => "",
      :retailer => "",
      :longitude => 1.5,
      :latitude => 1.5,
      :description => "MyText"
    ))
  end

  it "renders the edit store form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stores_path(@store), :method => "post" do
      assert_select "input#store_name", :name => "store[name]"
      assert_select "input#store_address", :name => "store[address]"
      assert_select "input#store_address2", :name => "store[address2]"
      assert_select "input#store_postcode", :name => "store[postcode]"
      assert_select "input#store_store_format", :name => "store[store_format]"
      assert_select "input#store_retailer", :name => "store[retailer]"
      assert_select "input#store_longitude", :name => "store[longitude]"
      assert_select "input#store_latitude", :name => "store[latitude]"
      assert_select "textarea#store_description", :name => "store[description]"
    end
  end
end
