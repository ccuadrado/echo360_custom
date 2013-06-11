# == Schema Information
# Schema version: 20100614205416
#
# Table name: schedule_rules
#
#  id             :integer         not null, primary key
#  essid          :string(255)     not null
#  title          :string(255)     not null
#  section_essid  :string(255)     not null
#  section_id     :string(255)     not null
#  room           :string(255)     not null
#  description    :string(255)     not null
#  start_date     :date            not null
#  start_time     :time            not null
#  duration       :integer         not null
#  end_date       :date            not null
#  recurring      :boolean         not null
#  monday         :boolean         not null
#  tuesday        :boolean         not null
#  wednesday      :boolean         not null
#  thursday       :boolean         not null
#  friday         :boolean         not null
#  saturday       :boolean         not null
#  sunday         :boolean         not null
#  excluded_dates :string(255)     not null
#  presenters     :string(255)     default("--- []"), not null
#  captures       :string(255)     not null
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

require 'spec_helper'

describe ScheduleRule do
  before(:each) do
    @valid_attributes = {
      :essid => "value for essid",
      :title => "value for title",
      :section_essid => "value for section_essid",
      :section_id => "value for section_id",
      :room => "value for room",
      :description => "value for description",
      :start_date => Date.today,
      :start_time => Time.now,
      :end_date => Date.today,
      :recurring => false,
      :days_of_week => "value for days_of_week",
      :excluded_dates => "value for excluded_dates",
      :presenters => "value for presenters",
      :captures => "value for captures"
    }
  end

  it "should create a new instance given valid attributes" do
    ScheduleRule.create!(@valid_attributes)
  end
end
