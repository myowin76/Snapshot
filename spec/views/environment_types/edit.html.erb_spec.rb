require 'spec_helper'

describe "environment_types/edit" do
  before(:each) do
    @environment_type = assign(:environment_type, stub_model(EnvironmentType,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit environment_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => environment_types_path(@environment_type), :method => "post" do
      assert_select "input#environment_type_name", :name => "environment_type[name]"
      assert_select "input#environment_type_description", :name => "environment_type[description]"
    end
  end
end
