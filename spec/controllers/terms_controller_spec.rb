require 'spec_helper'

describe TermsController do

  #Delete these examples and add some real ones
  it "should use TermsController" do
    controller.should be_an_instance_of(TermsController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
end
