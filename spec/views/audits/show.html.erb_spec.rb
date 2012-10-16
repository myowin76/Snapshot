require 'spec_helper'

describe "audits/show" do
  before(:each) do
    @audit = assign(:audit, stub_model(Audit,
      :store => nil,
      :environment_type => nil,
      :channel => nil,
      :retailer => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
