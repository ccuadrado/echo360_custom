require 'spec_helper'

describe PresentersController do

  def mock_presenter(stubs={})
    @mock_presenter ||= mock_model(Presenter, stubs)
  end

  describe "GET index" do
    it "assigns all presenters as @presenters" do
      Presenter.stub(:find).with(:all).and_return([mock_presenter])
      get :index
      assigns[:presenters].should == [mock_presenter]
    end
  end

  describe "GET show" do
    it "assigns the requested presenter as @presenter" do
      Presenter.stub(:find).with("37").and_return(mock_presenter)
      get :show, :id => "37"
      assigns[:presenter].should equal(mock_presenter)
    end
  end

  describe "GET new" do
    it "assigns a new presenter as @presenter" do
      Presenter.stub(:new).and_return(mock_presenter)
      get :new
      assigns[:presenter].should equal(mock_presenter)
    end
  end

  describe "GET edit" do
    it "assigns the requested presenter as @presenter" do
      Presenter.stub(:find).with("37").and_return(mock_presenter)
      get :edit, :id => "37"
      assigns[:presenter].should equal(mock_presenter)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created presenter as @presenter" do
        Presenter.stub(:new).with({'these' => 'params'}).and_return(mock_presenter(:save => true))
        post :create, :presenter => {:these => 'params'}
        assigns[:presenter].should equal(mock_presenter)
      end

      it "redirects to the created presenter" do
        Presenter.stub(:new).and_return(mock_presenter(:save => true))
        post :create, :presenter => {}
        response.should redirect_to(presenter_url(mock_presenter))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved presenter as @presenter" do
        Presenter.stub(:new).with({'these' => 'params'}).and_return(mock_presenter(:save => false))
        post :create, :presenter => {:these => 'params'}
        assigns[:presenter].should equal(mock_presenter)
      end

      it "re-renders the 'new' template" do
        Presenter.stub(:new).and_return(mock_presenter(:save => false))
        post :create, :presenter => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested presenter" do
        Presenter.should_receive(:find).with("37").and_return(mock_presenter)
        mock_presenter.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :presenter => {:these => 'params'}
      end

      it "assigns the requested presenter as @presenter" do
        Presenter.stub(:find).and_return(mock_presenter(:update_attributes => true))
        put :update, :id => "1"
        assigns[:presenter].should equal(mock_presenter)
      end

      it "redirects to the presenter" do
        Presenter.stub(:find).and_return(mock_presenter(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(presenter_url(mock_presenter))
      end
    end

    describe "with invalid params" do
      it "updates the requested presenter" do
        Presenter.should_receive(:find).with("37").and_return(mock_presenter)
        mock_presenter.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :presenter => {:these => 'params'}
      end

      it "assigns the presenter as @presenter" do
        Presenter.stub(:find).and_return(mock_presenter(:update_attributes => false))
        put :update, :id => "1"
        assigns[:presenter].should equal(mock_presenter)
      end

      it "re-renders the 'edit' template" do
        Presenter.stub(:find).and_return(mock_presenter(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested presenter" do
      Presenter.should_receive(:find).with("37").and_return(mock_presenter)
      mock_presenter.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the presenters list" do
      Presenter.stub(:find).and_return(mock_presenter(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(presenters_url)
    end
  end

end
