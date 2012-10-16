require 'spec_helper'

describe "audits/new" do
  before(:each) do
    assign(:audit, stub_model(Audit,
      :store => nil,
      :environment_type => nil,
      :channel => nil,
      :retailer => nil
    ).as_new_record)
  end

  it "renders new audit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => audits_path, :method => "post" do
      assert_select "input#audit_store", :name => "audit[store]"
      assert_select "input#audit_environment_type", :name => "audit[environment_type]"
      assert_select "input#audit_channel", :name => "audit[channel]"
      assert_select "input#audit_retailer", :name => "audit[retailer]"
    end
  end
end
