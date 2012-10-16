require 'spec_helper'

describe "audits/edit" do
  before(:each) do
    @audit = assign(:audit, stub_model(Audit,
      :store => nil,
      :environment_type => nil,
      :channel => nil,
      :retailer => nil
    ))
  end

  it "renders the edit audit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => audits_path(@audit), :method => "post" do
      assert_select "input#audit_store", :name => "audit[store]"
      assert_select "input#audit_environment_type", :name => "audit[environment_type]"
      assert_select "input#audit_channel", :name => "audit[channel]"
      assert_select "input#audit_retailer", :name => "audit[retailer]"
    end
  end
end
