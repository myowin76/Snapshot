require 'spec_helper'

describe "stores/show" do
  before(:each) do
    @store = assign(:store, stub_model(Store,
      :name => "Name",
      :address => "Address",
      :address2 => "Address2",
      :postcode => "Postcode",
      :store_format => "",
      :retailer => "",
      :longitude => 1.5,
      :latitude => 1.5,
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Address/)
    rendered.should match(/Address2/)
    rendered.should match(/Postcode/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/MyText/)
  end
end
