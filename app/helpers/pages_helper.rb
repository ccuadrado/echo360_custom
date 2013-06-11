module PagesHelper
  include ApplicationHelper
  
  def show_device_links

    links = [["Duques 151", '128.164.61.233'],
             ["Duques 152", '128.164.62.68'],
             ["Duques 250", '128.164.61.227'],
             ["Duques 251", '128.164.62.72'],
             ["Duques 255", '128.164.61.99'],
             ["Duques 651", '128.164.61.31'],
             ["", ""],
             ["Duques 651 Backup", '128.164.63.97'],
             ["Rome 204", '128.164.61.58']
            ]
    ret_val = ""
    links.each do |link|
      ret_val << link_to(link[0], 'https://'+link[1]+':8443/', :class => "device_link") << '<br />'
    end
    return ret_val
  end
  
  def sync_all_helper
    @requester = HttpRequester.new("get", Credentials.key, Credentials.secret)
    sync_buildings
    sync_rooms
    sync_captures
    sync_presenters
    sync_terms
    sync_courses
    sync_sections
    
    AppData.update_create(@last_sync, {:key => 'last_sync', :value => Time.now.localtime.to_s})
    flash[:notice] = "Synced with Server"
  end
  
  def sync_presenters
    url = [[URI.parse(Credentials.server + "people"), nil]]    
    Presenter.transaction do
    
      #Presenter.delete_all
      
      @requester.request(url)[0].each do |presenter|
        params = {:essid => presenter.get_node("id").value,
                  :first_name => presenter.get_node("first_name").value,
                  :last_name => presenter.get_node("last_name").value,
                  :created_time => presenter.get_node("created_time").value,
                  }
        sync(Presenter, params)
      end
    end
  end

  def sync_rooms
    url = [[URI.parse(Credentials.server + "rooms"),nil]]
    
    Room.transaction do
      #Room.delete_all
    
      @requester.request(url)[0].each do |room|
        params = {:essid => room.get_node("id").value, 
                  :name => room.get_node("name").value,
                  :building => room.get_node("building").value[-36,36]
                      }
        sync(Room, params)
      end
    end #end transaction
    
  end
  
  def sync_buildings
    url = [[URI.parse(Credentials.server + "buildings"),nil]]
    
    Building.transaction do
      #Building.delete_all
      
      @requester.request(url)[0].each do |building|
        params = {:essid => building.get_node("id").value, 
                  :name => building.get_node("name").value,
                  :campus => building.get_node("campus").value[-36,36]
                 }
        sync(Building, params)
      end
    end #end transaction
  end
  
  def sync_terms
    url = [[URI.parse(Credentials.server + "terms"),nil]]
    
    Term.transaction do
      #Term.delete_all
    
      @requester.request(url)[0].each do |term|
        params = {:essid => term.get_node("id").value, 
                  :name => term.get_node("name").value,
                  :start_date => Time.parse(term.get_node("start_date").value),
                  :end_date => Time.parse(term.get_node("end_date").value)
                      }
        sync(Term, params)
      end
    end #end transaction
    
  end
  
    #syncs all captures
  def sync_captures
    Capture.transaction do
 
      #not dropping the table since this incurs a huge hit later on
      #Capture.delete_all
    
      Room.all.each do |room|
        room_name = find(Building, ["essid = ?", room.building]).name + ' ' + room.name
#        Building.find(:first, :conditions => 
#                      ["essid = ?", room.building]).name + " " + room.name
        url = [[URI.parse(Credentials.server + "rooms/" + room.essid + "/captures"), nil]]
   
        @requester.request(url)[0].each do |capture|
          params = {:essid => capture.get_node("id").value,
                    :start_time => Time.parse(capture.get_node("scheduled_start_time").value),
                    :duration => capture.get_node("scheduled_duration_seconds").value.to_i,
                    :room_name => room_name                    
                    }
          sync(Capture, params)
        end
      end
    end #end transaction
  end
  
  def sync_courses
    url = [[URI.parse(Credentials.server + "courses"),nil]]
    
    Course.transaction do
      #Course.delete_all
      
      @requester.request(url)[0].each do |course|
      params = {:essid => course.get_node("id").value, 
                :name => course.get_node("name").value,
                :identifier => course.get_node("identifier").value
                }
      sync(Course, params)
      end
    end
  
  end
  
  def sync_sections
    Section.transaction do
    
      Term.all.each do |term|
      
        url = [[URI.parse(Credentials.server + "terms/" + term.essid + "/sections"), nil]]
        
        @requester.request(url)[0].each do |section|
          params = {:essid => section.get_node("id").value,
                    :course => section.get_node("course").value[-36,36],
                    :name => section.get_node("name").value
                   }
          sync(Section, params)
        end
      end  
    end
    
  end
  
end
