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

require 'spec_helper'

describe Section do
  before(:each) do
    @valid_attributes = {
      :essid => "value for essid",
      :course => "value for course",
      :name => "value for name",
      :section_complete => false,
      :publishing_complete => false,
      :do_not_publish => false,
      :default_publishers_set => false,
      :presenters => "value for presenters"
      #:schedule_rules => ["value for schedule_rules"]
    }
  end

  it "should create a new instance given valid attributes" do
    Section.create!(@valid_attributes)
  end
end
