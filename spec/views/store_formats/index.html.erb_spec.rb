require 'spec_helper'

describe "store_formats/index" do
  before(:each) do
    assign(:store_formats, [
      stub_model(StoreFormat,
        :name => "Name",
        :description => "MyText"
      ),
      stub_model(StoreFormat,
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of store_formats" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
