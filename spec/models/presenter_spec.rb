# == Schema Information
# Schema version: 20100614205416
#
# Table name: presenters
#
#  id            :integer         not null, primary key
#  essid         :string(255)     not null
#  last_name     :string(255)     not null
#  first_name    :string(255)     not null
#  created_time  :datetime        not null
#  email_address :string(255)     not null
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'spec_helper'

describe Presenter do
  before(:each) do
    @valid_attributes = {
      :essid => "value for essid",
      :last_name => "value for last_name",
      :first_name => "value for first_name",
      :created_time => Time.now,
      :email_address => "value for email_address"
    }
  end

  it "should create a new instance given valid attributes" do
    Presenter.create!(@valid_attributes)
  end
end
