module ScheduleRulesHelper
  include ApplicationHelper
  
  #Syncs all schedule rules that are related to this section
  def sync_schedule_rules(section)
    
    url = [[URI.parse(Credentials.server + 'sections/' + section.essid + '/schedule-rules'), nil]]
    requester = HttpRequester.new('get', Credentials.key, Credentials.secret)
    
    ScheduleRule.transaction do
      #ScheduleRule.delete_all("section_id = #{section.id}")
      requester.request(url)[0].each do |rule|
        sync_schedule_rule(rule.get_node("self").value[-36,36])
      end
    end
  end

  #Sync single schedule rule from the ESS by essid
  def sync_schedule_rule(essid)
    requester = HttpRequester.new('get', Credentials.key, Credentials.secret)
    uri = [[URI.parse(Credentials.server + 'schedule-rules/' + essid),nil]]
    response = requester.request(uri)[0]
    presenters = response.get_node("presenters")
    presenters_array = Array.new
    if(!presenters.nil?)
      3.times { presenters.remove_node(0) }
      presenters.each { |presenter| presenters_array << presenter.get_node("person").get_node("id").value}
    end
    #format time and days of the week here
    start_time = response.get_node("start_time").value
    start_date = response.get_node("start_date").value
    end_date = response.get_node("end_date").value
    
    (start_time = Time.parse(start_time)+18000) unless start_time.nil? #timezone problems
    (start_date = Time.parse(start_date)) unless start_date.nil?
    (end_date = Time.parse(end_date)) unless end_date.nil?
    
    days_of_week = response.get_node("days_of_week")
    
    
    room = response.get_node("room")
    room.nil? ? (room = "") : (room = room.value[-36,36])
    
    section = find(Section, {:essid => response.get_node("section").value[-36,36]})

    params = {:essid => response.get_node("id").value,
              :section_essid => response.get_node("section").value[-36,36],
              :section_id => section.id,
              :room => room,
              :title => response.get_node("title").value,
              :description => response.get_node("description").value,
              :start_time => start_time,
              :start_date => start_date,
              :end_date => end_date,
              :duration => response.get_node("duration_seconds").value,
              :presenters => presenters_array,
              :recurring => response.get_node("recurring").value,
              :monday => days_of_week.get_node("monday").value,
              :tuesday => days_of_week.get_node("tuesday").value,
              :wednesday => days_of_week.get_node("wednesday").value,
              :thursday => days_of_week.get_node("thursday").value,
              :friday => days_of_week.get_node("friday").value,
              :saturday => days_of_week.get_node("saturday").value,
              :sunday => days_of_week.get_node("sunday").value
             }
    sync(ScheduleRule, params)
  end

end
