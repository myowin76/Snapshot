require 'spec_helper'

describe "environment_types/show" do
  before(:each) do
    @environment_type = assign(:environment_type, stub_model(EnvironmentType,
      :name => "Name",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Description/)
  end
end
