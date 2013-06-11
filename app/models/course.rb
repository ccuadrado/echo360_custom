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

class Course < ActiveRecord::Base
end
