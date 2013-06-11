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

class Room < ActiveRecord::Base
  
  def full_name
    building_temp = Building.find(:first, :conditions => {:essid => building})
    "#{building_temp.name} - #{name}"
  end

end
