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

class Term < ActiveRecord::Base
end
