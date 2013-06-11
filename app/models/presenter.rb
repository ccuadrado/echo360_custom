# == Schema Information
# Schema version: 20100614205416
#
# Table name: presenters
#
#  id            :integer         not null, primary key
#  essid         :string(255)     not null
#  last_name     :string(255)     not null
#  first_name    :string(255)     not null
#  created_time  :datetime        not null
#  email_address :string(255)     not null
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class Presenter < ActiveRecord::Base

  def full_name
    return "#{last_name}, #{first_name}"
  end

end
