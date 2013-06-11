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

class Capture < ActiveRecord::Base
end
