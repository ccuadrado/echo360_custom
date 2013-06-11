require 'spec_helper'

describe PresentersController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/presenters" }.should route_to(:controller => "presenters", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/presenters/new" }.should route_to(:controller => "presenters", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/presenters/1" }.should route_to(:controller => "presenters", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/presenters/1/edit" }.should route_to(:controller => "presenters", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/presenters" }.should route_to(:controller => "presenters", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/presenters/1" }.should route_to(:controller => "presenters", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/presenters/1" }.should route_to(:controller => "presenters", :action => "destroy", :id => "1") 
    end
  end
end
