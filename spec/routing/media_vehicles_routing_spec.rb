require "spec_helper"

describe MediaVehiclesController do
  describe "routing" do

    it "routes to #index" do
      get("/media_vehicles").should route_to("media_vehicles#index")
    end

    it "routes to #new" do
      get("/media_vehicles/new").should route_to("media_vehicles#new")
    end

    it "routes to #show" do
      get("/media_vehicles/1").should route_to("media_vehicles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/media_vehicles/1/edit").should route_to("media_vehicles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/media_vehicles").should route_to("media_vehicles#create")
    end

    it "routes to #update" do
      put("/media_vehicles/1").should route_to("media_vehicles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/media_vehicles/1").should route_to("media_vehicles#destroy", :id => "1")
    end

  end
end
