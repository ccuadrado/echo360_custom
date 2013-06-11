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

class Building < ActiveRecord::Base
end
