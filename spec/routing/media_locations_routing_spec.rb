require "spec_helper"

describe MediaLocationsController do
  describe "routing" do

    it "routes to #index" do
      get("/media_locations").should route_to("media_locations#index")
    end

    it "routes to #new" do
      get("/media_locations/new").should route_to("media_locations#new")
    end

    it "routes to #show" do
      get("/media_locations/1").should route_to("media_locations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/media_locations/1/edit").should route_to("media_locations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/media_locations").should route_to("media_locations#create")
    end

    it "routes to #update" do
      put("/media_locations/1").should route_to("media_locations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/media_locations/1").should route_to("media_locations#destroy", :id => "1")
    end

  end
end
