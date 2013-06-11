class PresentersController < ApplicationController
  include PresentersHelper
  # GET /presenters
  # GET /presenters.xml

  before_filter :set_title
  
  def set_title
    @title = "Presenters"
  end

  def index
    @presenters = Presenter.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @presenters }
    end
  end

  # GET /presenters/1
  # GET /presenters/1.xml
  def show
    @presenter = Presenter.find(params[:id])
    
    requester = HttpRequester.new("get", Credentials.key, Credentials.secret)
    uri = [[URI.parse(Credentials.server + 'people/' + @presenter.essid), nil]]
    detailed = requester.request(uri)[0]
    email = detailed.get_node("email_address").value
    @presenter = Presenter.update(@presenter.id, :email_address => email)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @presenter }
    end
  end

  # GET /presenters/new
  # GET /presenters/new.xml
  def new
    @presenter = Presenter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @presenter }
    end
  end

  # GET /presenters/1/edit
  def edit
    @presenter = Presenter.find(params[:id])
  end

  # POST /presenters
  # POST /presenters.xml
  def create
    #@presenter = Presenter.new(params[:presenter])
    requester = HttpRequester.new("post", Credentials.key, Credentials.secret)
    person = generate_person_xml(params[:presenter])
    uri = [[URI.parse(Credentials.server + 'people/'), person.inspect]]
    response = requester.request_raw(uri)[0]
    
    respond_to do |format|
      if (response.code == '200')
        #Add the ESS-ID to @presenter and save it
        xml = XmlNode.parse(response.body)
        parameters = {:essid => xml.get_node("id").value,
                  :first_name => xml.get_node("first-name").value,
                  :last_name => xml.get_node("last-name").value,
                  :email_address => xml.get_node("email-address").value,
                  :created_time => xml.get_node("created_time").value,
                  }
        sync(Presenter, parameters)
        @presenter = find(Presenter, {:essid => xml.get_node("id").value})
        
        flash[:notice] = 'Presenter was successfully created.'
        format.html { redirect_to(@presenter) }
        format.xml  { render :xml => @presenter, :status => :created, :location => @presenter }
      else
        flash[:notice] = 'Presenter could not be created. HTTP Error code ' + response.code
        format.html { render :action => "new" }
        format.xml  { render :xml => @presenter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /presenters/1
  # PUT /presenters/1.xml
  def update
     # UPDATE OPERATIONS ARE NOT ALLOWED: USERS WILL HAVE TO LOG INTO ESS TO EDIT THEIR DATA. DON'T WANT THINGS TO GET OUT OF SYNC
  end

  # DELETE /presenters/1
  # DELETE /presenters/1.xml
  def destroy
    # DESTROY OPERATIONS NOT ALLOWED.
    # @presenter = Presenter.find(params[:id])
    # @presenter.destroy
    # respond_to do |format|
    # format.html { redirect_to(presenters_url) }
    # format.xml  { head :ok }
    end
end
