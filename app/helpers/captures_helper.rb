module CapturesHelper

  #Gets captures from the capture table within the 2 dates and returns the formatted
  #html.
  def get_captures
  
    if (@end_date >= @start_date)
      captures = Capture.find(:all, :conditions =>
                ["start_time >= ? AND start_time <= ?", @start_date, @end_date], 
                 :order => "start_time ASC")
    else
      captures = Capture.all
    end
    
    ret_val = Array.new
    requester = HttpRequester.new("get", Credentials.key, Credentials.secret)
    captures.each do |capture|
      if capture.title.nil?
        capture_uri = [[URI.parse(Credentials.server + 'captures/' + capture.essid), nil]]
        detailed = requester.request(capture_uri)[0]
        #puts detailed.inspect
        title = detailed.get_node("title").value
        section_essid = detailed.get_node("section").value[-36,36]
        schedule_rule_essid = detailed.get_node("schedule_rule").value[-36,36]
        
        Capture.update(capture.id, {:title => title, 
                                    :section_essid => section_essid,
                                    :schedule_rule_essid => schedule_rule_essid})
      else
        title = capture.title
        section_essid = capture.section_essid
        schedule_rule_essid = capture.schedule_rule_essid
      end

      section = find(Section, {:essid => section_essid})
      #TODO: Fix
      #Causes null pointer exception on server (even though it shouldn't)
      #sync_schedule_rule(schedule_rule_essid, section)
      #schedule_rule = ScheduleRule.find(:first, :conditions => {:essid => schedule_rule_essid})
      
      ret_val << [capture.start_time.localtime.strftime("%Y-%m-%d | %a %H:%M"), 
                  capture.room_name, 
                  #link_to(title, section_schedule_rule_path(section, schedule_rule))]
                  link_to(title, section)]
    end
    
    return ret_val
  end
  
end
