require 'spec_helper'

describe "channels/edit" do
  before(:each) do
    @channel = assign(:channel, stub_model(Channel,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit channel form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => channels_path(@channel), :method => "post" do
      assert_select "input#channel_name", :name => "channel[name]"
      assert_select "textarea#channel_description", :name => "channel[description]"
    end
  end
end
