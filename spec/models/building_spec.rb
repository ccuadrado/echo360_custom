# == Schema Information
# Schema version: 20100614205416
#
# Table name: buildings
#
#  id         :integer         not null, primary key
#  essid      :string(255)     not null
#  campus     :string(255)     not null
#  name       :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Building do
  before(:each) do
    @valid_attributes = {
      :essid => "value for essid",
      :campus => "value for campus",
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    Building.create!(@valid_attributes)
  end
end
