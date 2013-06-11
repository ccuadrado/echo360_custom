# == Schema Information
# Schema version: 20100614205416
#
# Table name: captures
#
#  id                  :integer         not null, primary key
#  essid               :string(255)     not null
#  start_time          :datetime        not null
#  duration            :integer         not null
#  title               :string(255)     not null
#  room_name           :string(255)     not null
#  section_essid       :string(255)     not null
#  schedule_rule_essid :string(255)     not null
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

require 'spec_helper'

describe Capture do
  before(:each) do
    @valid_attributes = {
      :essid => "value for essid",
      :start_time => "value for start_time",
      :title => "value for title",
      :room_name => "value for room_name"
    }
  end

  it "should create a new instance given valid attributes" do
    Capture.create!(@valid_attributes)
  end
end
