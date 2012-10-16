require 'spec_helper'

describe "environment_types/new" do
  before(:each) do
    assign(:environment_type, stub_model(EnvironmentType,
      :name => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new environment_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => environment_types_path, :method => "post" do
      assert_select "input#environment_type_name", :name => "environment_type[name]"
      assert_select "input#environment_type_description", :name => "environment_type[description]"
    end
  end
end
