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

require 'spec_helper'

describe AppData do
  before(:each) do
    @valid_attributes = {
      :key => "value for key",
      :value => "value for value"
    }
  end

  it "should create a new instance given valid attributes" do
    AppData.create!(@valid_attributes)
  end
end
