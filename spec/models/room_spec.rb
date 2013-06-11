# == Schema Information
# Schema version: 20100614205416
#
# Table name: rooms
#
#  id         :integer         not null, primary key
#  essid      :string(255)     not null
#  name       :string(255)     not null
#  building   :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Room do
  before(:each) do
    @valid_attributes = {
      :essid => "value for essid",
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    Room.create!(@valid_attributes)
  end
end
