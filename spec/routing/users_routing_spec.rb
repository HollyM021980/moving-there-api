require "rails_helper"

RSpec.describe UsersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/users", :format => 'json').to route_to("users#index")
    end

    it "routes to #show" do
      expect(:get => "/users/1").to route_to("users#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/users").to route_to("users#create")
    end

    it "routes to #update" do
      expect(:put => "/users/1").to route_to("users#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/users/1").to route_to("users#destroy", :id => "1")
    end

    it "routes to #login" do
      expect(:post => "/login").to route_to("users#login")
    end

    it "routes to #signup" do
      expect(:post => "/signup").to route_to("users#signup")
    end

    it "routes to #logout" do
      expect(:post => "/logout").to route_to("users#logout")
    end

  end
end
