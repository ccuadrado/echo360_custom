require 'spec_helper'

describe ScheduleRulesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/schedule_rules" }.should route_to(:controller => "schedule_rules", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/schedule_rules/new" }.should route_to(:controller => "schedule_rules", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/schedule_rules/1" }.should route_to(:controller => "schedule_rules", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/schedule_rules/1/edit" }.should route_to(:controller => "schedule_rules", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/schedule_rules" }.should route_to(:controller => "schedule_rules", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/schedule_rules/1" }.should route_to(:controller => "schedule_rules", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/schedule_rules/1" }.should route_to(:controller => "schedule_rules", :action => "destroy", :id => "1") 
    end
  end
end
