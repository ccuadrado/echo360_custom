require 'spec_helper'

describe ScheduleRulesController do

  def mock_schedule_rule(stubs={})
    @mock_schedule_rule ||= mock_model(ScheduleRule, stubs)
  end

  describe "GET index" do
    it "assigns all schedule_rules as @schedule_rules" do
      ScheduleRule.stub(:find).with(:all).and_return([mock_schedule_rule])
      get :index
      assigns[:schedule_rules].should == [mock_schedule_rule]
    end
  end

  describe "GET show" do
    it "assigns the requested schedule_rule as @schedule_rule" do
      ScheduleRule.stub(:find).with("37").and_return(mock_schedule_rule)
      get :show, :id => "37"
      assigns[:schedule_rule].should equal(mock_schedule_rule)
    end
  end

  describe "GET new" do
    it "assigns a new schedule_rule as @schedule_rule" do
      ScheduleRule.stub(:new).and_return(mock_schedule_rule)
      get :new
      assigns[:schedule_rule].should equal(mock_schedule_rule)
    end
  end

  describe "GET edit" do
    it "assigns the requested schedule_rule as @schedule_rule" do
      ScheduleRule.stub(:find).with("37").and_return(mock_schedule_rule)
      get :edit, :id => "37"
      assigns[:schedule_rule].should equal(mock_schedule_rule)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created schedule_rule as @schedule_rule" do
        ScheduleRule.stub(:new).with({'these' => 'params'}).and_return(mock_schedule_rule(:save => true))
        post :create, :schedule_rule => {:these => 'params'}
        assigns[:schedule_rule].should equal(mock_schedule_rule)
      end

      it "redirects to the created schedule_rule" do
        ScheduleRule.stub(:new).and_return(mock_schedule_rule(:save => true))
        post :create, :schedule_rule => {}
        response.should redirect_to(schedule_rule_url(mock_schedule_rule))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved schedule_rule as @schedule_rule" do
        ScheduleRule.stub(:new).with({'these' => 'params'}).and_return(mock_schedule_rule(:save => false))
        post :create, :schedule_rule => {:these => 'params'}
        assigns[:schedule_rule].should equal(mock_schedule_rule)
      end

      it "re-renders the 'new' template" do
        ScheduleRule.stub(:new).and_return(mock_schedule_rule(:save => false))
        post :create, :schedule_rule => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested schedule_rule" do
        ScheduleRule.should_receive(:find).with("37").and_return(mock_schedule_rule)
        mock_schedule_rule.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :schedule_rule => {:these => 'params'}
      end

      it "assigns the requested schedule_rule as @schedule_rule" do
        ScheduleRule.stub(:find).and_return(mock_schedule_rule(:update_attributes => true))
        put :update, :id => "1"
        assigns[:schedule_rule].should equal(mock_schedule_rule)
      end

      it "redirects to the schedule_rule" do
        ScheduleRule.stub(:find).and_return(mock_schedule_rule(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(schedule_rule_url(mock_schedule_rule))
      end
    end

    describe "with invalid params" do
      it "updates the requested schedule_rule" do
        ScheduleRule.should_receive(:find).with("37").and_return(mock_schedule_rule)
        mock_schedule_rule.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :schedule_rule => {:these => 'params'}
      end

      it "assigns the schedule_rule as @schedule_rule" do
        ScheduleRule.stub(:find).and_return(mock_schedule_rule(:update_attributes => false))
        put :update, :id => "1"
        assigns[:schedule_rule].should equal(mock_schedule_rule)
      end

      it "re-renders the 'edit' template" do
        ScheduleRule.stub(:find).and_return(mock_schedule_rule(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested schedule_rule" do
      ScheduleRule.should_receive(:find).with("37").and_return(mock_schedule_rule)
      mock_schedule_rule.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the schedule_rules list" do
      ScheduleRule.stub(:find).and_return(mock_schedule_rule(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(schedule_rules_url)
    end
  end

end
