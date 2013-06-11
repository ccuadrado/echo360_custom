# == Schema Information
# Schema version: 20100614205416
#
# Table name: terms
#
#  id         :integer         not null, primary key
#  essid      :string(255)     not null
#  name       :string(255)     not null
#  start_date :datetime        not null
#  end_date   :datetime        not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Term do
  before(:each) do
    @valid_attributes = {
      :essid => "value for essid",
      :name => "value for name",
      :start_date => Time.now,
      :end_date => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Term.create!(@valid_attributes)
  end
end
