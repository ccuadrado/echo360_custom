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

class ScheduleRule < ActiveRecord::Base

  belongs_to :section
  serialize :presenters

  def days_of_week
    #output = ['M','T','W','T','F','S','S']
    days = [monday, tuesday, wednesday, thursday, friday, saturday, sunday]
  end

  def presenters_names
    retVal = ""
    presenters.each { |presenter| retVal << Presenter.find(:first, :conditions => {:essid => presenter}).full_name << " " }
    return retVal
  end

end
