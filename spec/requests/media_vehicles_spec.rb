require 'spec_helper'

describe "MediaVehicles" do
  describe "GET /media_vehicles" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get media_vehicles_path
      response.status.should be(200)
    end
  end
end
