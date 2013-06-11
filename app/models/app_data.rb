# == Schema Information
# Schema version: 20100614205416
#
# Table name: app_datas
#
#  id         :integer         not null, primary key
#  key        :string(255)     not null
#  value      :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class AppData < ActiveRecord::Base

  def AppData.get(key)
    return find(:first, :conditions => {:key => key})
  end


end
