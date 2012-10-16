require 'spec_helper'

describe "store_formats/show" do
  before(:each) do
    @store_format = assign(:store_format, stub_model(StoreFormat,
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
