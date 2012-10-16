require "spec_helper"

describe EnvironmentTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/environment_types").should route_to("environment_types#index")
    end

    it "routes to #new" do
      get("/environment_types/new").should route_to("environment_types#new")
    end

    it "routes to #show" do
      get("/environment_types/1").should route_to("environment_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/environment_types/1/edit").should route_to("environment_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/environment_types").should route_to("environment_types#create")
    end

    it "routes to #update" do
      put("/environment_types/1").should route_to("environment_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/environment_types/1").should route_to("environment_types#destroy", :id => "1")
    end

  end
end
