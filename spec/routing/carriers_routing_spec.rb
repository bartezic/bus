require "spec_helper"

describe CarriersController do
  describe "routing" do

    it "routes to #index" do
      get("/carriers").should route_to("carriers#index")
    end

    it "routes to #new" do
      get("/carriers/new").should route_to("carriers#new")
    end

    it "routes to #show" do
      get("/carriers/1").should route_to("carriers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/carriers/1/edit").should route_to("carriers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/carriers").should route_to("carriers#create")
    end

    it "routes to #update" do
      put("/carriers/1").should route_to("carriers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/carriers/1").should route_to("carriers#destroy", :id => "1")
    end

  end
end
