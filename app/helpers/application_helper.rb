# Methods added to this helper will be available to all templates in the application.
require 'util/html_gen'
module ApplicationHelper
  require 'util/http_requester'
  require 'credentials'
  include HtmlGenerator

  #Return a title on a per-page basis.
  def title
    base_title = "Echo 360 Custom Interface"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{h(@title)}"
    end
  end
  
  def logo
    image_tag("logo.png", :alt => "Echo360 Customised!", :class => "round")
  end

  def sync(record, params)
    local = record.find(:first, :conditions => {:essid => params[:essid]})
    record.update_create(local, params)
  end

  #returns first match only
  def find(model, conditions)
    return model.find(:first, :conditions => conditions)
  end
  
end
