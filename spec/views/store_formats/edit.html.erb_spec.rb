require 'spec_helper'

describe "store_formats/edit" do
  before(:each) do
    @store_format = assign(:store_format, stub_model(StoreFormat,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit store_format form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => store_formats_path(@store_format), :method => "post" do
      assert_select "input#store_format_name", :name => "store_format[name]"
      assert_select "textarea#store_format_description", :name => "store_format[description]"
    end
  end
end
