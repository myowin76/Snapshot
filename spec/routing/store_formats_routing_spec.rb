require "spec_helper"

describe StoreFormatsController do
  describe "routing" do

    it "routes to #index" do
      get("/store_formats").should route_to("store_formats#index")
    end

    it "routes to #new" do
      get("/store_formats/new").should route_to("store_formats#new")
    end

    it "routes to #show" do
      get("/store_formats/1").should route_to("store_formats#show", :id => "1")
    end

    it "routes to #edit" do
      get("/store_formats/1/edit").should route_to("store_formats#edit", :id => "1")
    end

    it "routes to #create" do
      post("/store_formats").should route_to("store_formats#create")
    end

    it "routes to #update" do
      put("/store_formats/1").should route_to("store_formats#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/store_formats/1").should route_to("store_formats#destroy", :id => "1")
    end

  end
end
