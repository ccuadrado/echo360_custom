class PagesController < ApplicationController
  include PagesHelper
  
  before_filter :get_last_sync
  
  def get_last_sync
    @last_sync = (AppData.table_exists?) ? AppData.get('last_sync') : nil
    @last_sync_val = @last_sync.nil? ? nil : Time.parse(@last_sync.value)
  end
  
  def home
    @title = "Home"
  end

  def quick_dev
    @title = "Devices List"
  end

  def sync_all
    #Check if sync ocurred in last 2 minutes, perform sync if not, otherwise ignore
    if (@last_sync_val.nil? || (@last_sync_val < (Time.now - 180).localtime))
      #Sync here
      sync_all_helper
    else
    #no sync
      flash[:notice] = "Last sync was #{@last_sync_val.localtime.inspect}." +
                        'Please leave 3 minutes between synchronizations.'
    end
    redirect_to :action => "home"
  end
  
  def clear_db
    Building.delete_all
    Room.delete_all
    Capture.delete_all
    Presenter.delete_all
    Term.delete_all
    Course.delete_all
    Section.delete_all
    
    flash[:notice] = "Databases have been cleared. Please sync."
    redirect_to :action => "home"
  end
  
  #Test action, doesn't do anything yet
  def show_request
    @requester = HttpRequester.new("get", Credentials.key, Credentials.secret)
    server = 'http://127.0.0.1:3000/'
    url = [[URI.parse(server + "request"),nil]]
    
    #@requester.request_raw(url)[0]
    flash[:notice] = "You clicked show_request"
    redirect_to :action => "home"
    
  end
  
end
