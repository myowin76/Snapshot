require 'spec_helper'

describe "store_formats/new" do
  before(:each) do
    assign(:store_format, stub_model(StoreFormat,
      :name => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new store_format form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => store_formats_path, :method => "post" do
      assert_select "input#store_format_name", :name => "store_format[name]"
      assert_select "textarea#store_format_description", :name => "store_format[description]"
    end
  end
end
