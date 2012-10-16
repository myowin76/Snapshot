require 'spec_helper'

describe "photos/edit" do
  before(:each) do
    @photo = assign(:photo, stub_model(Photo,
      :brand => nil,
      :audit => nil,
      :category => nil,
      :media_location => nil,
      :media_vehicle => nil,
      :media_type => nil,
      :description => "MyText"
    ))
  end

  it "renders the edit photo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => photos_path(@photo), :method => "post" do
      assert_select "input#photo_brand", :name => "photo[brand]"
      assert_select "input#photo_audit", :name => "photo[audit]"
      assert_select "input#photo_category", :name => "photo[category]"
      assert_select "input#photo_media_location", :name => "photo[media_location]"
      assert_select "input#photo_media_vehicle", :name => "photo[media_vehicle]"
      assert_select "input#photo_media_type", :name => "photo[media_type]"
      assert_select "textarea#photo_description", :name => "photo[description]"
    end
  end
end
