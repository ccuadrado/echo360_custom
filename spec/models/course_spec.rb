# == Schema Information
# Schema version: 20100614205416
#
# Table name: courses
#
#  id         :integer         not null, primary key
#  essid      :string(255)     not null
#  name       :string(255)     not null
#  identifier :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Course do
  before(:each) do
    @valid_attributes = {
      :essid => "value for essid",
      :name => "value for name",
      :identifier => "value for identifier"
    }
  end

  it "should create a new instance given valid attributes" do
    Course.create!(@valid_attributes)
  end
end
