# == Schema Information
# Schema version: 20100614205416
#
# Table name: sections
#
#  id                     :integer         not null, primary key
#  essid                  :string(255)     not null
#  course                 :string(255)     not null
#  name                   :string(255)     not null
#  section_complete       :boolean         not null
#  publishing_complete    :boolean         not null
#  do_not_publish         :boolean         not null
#  default_publishers_set :boolean         not null
#  presenters             :string(255)     default("--- []"), not null
#  schedule_rules         :string(255)     not null
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#

class Section < ActiveRecord::Base

  has_many :schedule_rules
  serialize :presenters

  def presenters_names
    retVal = ""
    return "" if presenters.nil?
    presenters.each { |presenter| retVal << Presenter.find(:first, :conditions => {:essid => presenter}).full_name << " " }
    return retVal
  end

end
