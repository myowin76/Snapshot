require 'spec_helper'

describe "brands/edit" do
  before(:each) do
    @brand = assign(:brand, stub_model(Brand,
      :name => "MyString",
      :owner => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit brand form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => brands_path(@brand), :method => "post" do
      assert_select "input#brand_name", :name => "brand[name]"
      assert_select "input#brand_owner", :name => "brand[owner]"
      assert_select "textarea#brand_description", :name => "brand[description]"
    end
  end
end
