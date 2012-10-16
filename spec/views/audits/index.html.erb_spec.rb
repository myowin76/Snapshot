require 'spec_helper'

describe "audits/index" do
  before(:each) do
    assign(:audits, [
      stub_model(Audit,
        :store => nil,
        :environment_type => nil,
        :channel => nil,
        :retailer => nil
      ),
      stub_model(Audit,
        :store => nil,
        :environment_type => nil,
        :channel => nil,
        :retailer => nil
      )
    ])
  end

  it "renders a list of audits" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
