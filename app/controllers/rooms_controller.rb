class RoomsController < ApplicationController
  # GET /rooms
  # GET /rooms.xml
  
  before_filter :set_title
  
  def set_title
    @title = "Rooms"
  end
  
  def index
    @buildings = Building.all
    @rooms = Room.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rooms }
    end
  end

  # GET /rooms/1
  # GET /rooms/1.xml
  def show
    @room = Room.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @room }
    end
  end

  # GET /rooms/new
  # GET /rooms/new.xml
  def new
    @room = Room.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @room }
    end
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
  end

  # POST /rooms
  # POST /rooms.xml
  def create
    @room = Room.new(params[:room])
    #requester = HttpRequester('post', self.key, self.secret)
    url = URI.parse(Credentials.server + "buildings/" + building_id + "/rooms")
    response = requester.request([[url,xml_info]])[0]
    
    respond_to do |format|
#      if @room.save
      if response.key != 'error'
        @room[:essid] = response.get_node("id").value
         
        flash[:notice] = 'Room was successfully created.'
        format.html { redirect_to(@room) }
        format.xml  { render :xml => @room, :status => :created, :location => @room }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @room.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.xml
  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      #if @room.update_attributes(params[:room])
      #  flash[:notice] = 'Room was successfully updated.'
      #  format.html { redirect_to(@room) }
      #  format.xml  { head :ok }
      #else
      #  format.html { render :action => "edit" }
      #  format.xml  { render :xml => @room.errors, :status => :unprocessable_entity }
      #end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.xml
  def destroy
    #@room = Room.find(params[:id])
    #@room.destroy

    respond_to do |format|
      format.html { redirect_to(rooms_url) }
      format.xml  { head :ok }
    end
  end
end
