class ScheduleRulesController < ApplicationController
  include ScheduleRulesHelper#util/html_gen.rb
  
  #before_filter :get_section, :get_course, :set_title
  
  def get_section
    #@section = Section.find(params[:section_id])
    @section = Section.all
  end
  
  #def get_course
  #  @course = find(Course, {:essid => @section.course})
  #  #Course.find(:first, :conditions => {:essid => @section.course})
  #end
  
  def format_days
    @days_of_week = ""
    day_string = ['M', 'Tu', 'W', 'Th', 'F', 'Sa', 'Su']
    days = @schedule_rule.days_of_week
    i = 0
    days.each do |day|
      if day
        @days_of_week << content_tag(:span, day_string[i], {:class => "text_selected"}) << "\n"
      else
        @days_of_week << content_tag(:span, day_string[i], {:class => "text_fade"}) << "\n"
      end
      i += 1
    end
  end
  
  def set_title
    @title = "Schedule Rules"
  end
  
  ###############REST FUNCTIONS##################
  # GET /schedule_rules
  # GET /schedule_rules.xml
  def index

    sync_schedule_rules(@section)
    @schedule_rules = @section.schedule_rules.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @schedule_rules }
    end
  end

  # GET /schedule_rules/1
  # GET /schedule_rules/1.xml
  def show
    @schedule_rule = @section.schedule_rules.find(params[:id])
    format_days
    
    room = find(Room, {:essid => @schedule_rule.room})
    if (room.nil?)
      @room_name = ""
      @building_name = ""
    else
      @room_name = room.name
      @building_name = find(Building, {:essid => room.building}).name unless room.nil?
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @schedule_rule }
    end
  end

  # GET /schedule_rules/new
  # GET /schedule_rules/new.xml
  def new
    @schedule_rule = @section.schedule_rules.new #ScheduleRule.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => [@section, @schedule_rule] }
    end
  end

  # GET /schedule_rules/1/edit
  def edit
    @schedule_rule = @section.schedule_rules.find(params[:id])
    @schedule_rule.duration = @schedule_rule.duration/60 #Converting seconds to minutes
    @schedule_rule.start_time -= 5.hours #subtracting 5 hours to fix time zone problems
  end

  # POST /schedule_rules
  # POST /schedule_rules.xml
  def create
    
    #TODO: Format dates and stuff properly, put into a new hash and send it as Put/Post request
    rule = params[:schedule_rule]
    rule = rule.merge({:section_essid => @section.essid,
                       :essid => rand(100000).to_s, #generate random essid as a holder
                       :duration => rule[:duration].to_i*60, #save duration as seconds
                       
                       #Adding 5 to fix time zone problems
                       'start_time(4i)' => ((rule['start_time(4i)'].to_i+5)%24).to_s
                      })
    
    @schedule_rule = @section.schedule_rules.new(rule)
    
    #TODO:Send create POST/PUT to server instead of storing into a local db OR
    #if storing locally before creating on server, allow essid to be :null
    respond_to do |format|
      if @schedule_rule.save
      #if true
        flash[:notice] = 'ScheduleRule was successfully created.'
        format.html { redirect_to([@section,@schedule_rule]) }
        format.xml  { render :xml => [@section, @schedule_rule], :status => :created, :location => @schedule_rule }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @schedule_rule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /schedule_rules/1
  # PUT /schedule_rules/1.xml
  def update
  #puts 'TEST- sched controller' + @section.schedule_rules.find(params[:id]).inspect
    @schedule_rule = @section.schedule_rules.find(params[:id])

    #TODO: Format dates and stuff properly, put into a new hash and send it as Put/Post request
    rule = params[:schedule_rule]
    rule = rule.merge({:duration => rule[:duration].to_i*60 #converting minutes to seconds
                       })

    respond_to do |format|
      if @schedule_rule.update_attributes(rule)
        flash[:notice] = 'ScheduleRule was successfully updated.'
        format.html { redirect_to([@section, @schedule_rule]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @schedule_rule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /schedule_rules/1
  # DELETE /schedule_rules/1.xml
  # Should eventually send the delete request to ESS instead of trying to delete it from the
  # local DB (which doesn't work anyways)
  def destroy
    @schedule_rule = @section.schedule_rules.find(params[:id])
    @schedule_rule.destroy

    respond_to do |format|
      format.html { redirect_to(section_schedule_rules_url) }
      format.xml  { head :ok }
    end
  end
end
