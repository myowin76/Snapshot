require 'spec_helper'

describe "retailers/edit" do
  before(:each) do
    @retailer = assign(:retailer, stub_model(Retailer,
      :name => "MyString",
      :sector => "",
      :description => "MyText"
    ))
  end

  it "renders the edit retailer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => retailers_path(@retailer), :method => "post" do
      assert_select "input#retailer_name", :name => "retailer[name]"
      assert_select "input#retailer_sector", :name => "retailer[sector]"
      assert_select "textarea#retailer_description", :name => "retailer[description]"
    end
  end
end
