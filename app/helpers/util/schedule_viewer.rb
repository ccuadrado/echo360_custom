require 'src/iso_date.rb'
require 'src/http_requester.rb'


require 'net/http'
require 'uri'
class ScheduleViewer
  
  def initialize(server, key, secret, startDate = IsoDate.new, endDate = IsoDate.new(Time.new + 604800))
    if (startDate === IsoDate && endDate === IsoDate)
      @startDate = startDate
      @endDate = endDate
    else #defaults if given garbage input
      @startDate = IsoDate.new(Time.new)
      @endDate = IsoDate.new(Time.new + 604800)
    end
    @server = server
    @requester = HttpRequester.new("get", key, secret)
  end
  
  #Gets schedules using http request
  #processes schedule then returns it
  #returns a string
  def get_schedule
    #returns xmlnodes
    captures = get_captures
    schedules = Array.new
    
    captures.each do |capture|
      schedules << [get_date(capture), get_info(capture)]
    end
    
    schedules = schedules.sort {|x,y| x[0] <=> y[0]}
    
    string = String.new
    schedules.each do |schedule|
      string << schedule[1] + "\n"
    end
    return string
  end
  
  def get_captures
    #get rooms xml
    rooms = get_rooms
    
    #Build array of capture request URIs
    returnVal = XmlNode.new("captures");
    rooms.each do |room|
      id = room.get_node("id").value
      roomName = room.get_node("building").value

      capture_uri = [[URI.parse(@server + "rooms/" + id + "/captures"), nil]]
      
      #Perform summary capture requests for each room i
      #check if it is within the date desired, request the detailed element
      captureDetailed = @requester.request(capture_uri)[0]      
      captureDetailed.each do |capture|
        if(within_date(capture))
          capture_detailed = @requester.request([[URI.parse(@server + "captures/" + capture.get_node("id").value), nil]])[0]
          capture_detailed.put_node("room_name", roomName)
          returnVal.put_node(capture_detailed)
        end
      end
    end
    return returnVal
  end
  
  def get_rooms
    url = URI.parse(@server + "rooms")
    return @requester.request([[url,nil]])[0]
  end
  
  #returns true if the date is within startDate and endDate, false otherwise
  def within_date(node)
    date = IsoDate.new(node.get_node('scheduled_start_time').value)
    return ((date > @startDate) && (date < @endDate))
  end

  #gets the date of a capture and returns it
  def get_date(capture)
    return capture.get_node("start_time").value
  end
  
  def get_info(capture)
    return Time.parse(capture.get_node("start_time").value).inspect + " " + capture.get_node("title").value  
  end
  
end
