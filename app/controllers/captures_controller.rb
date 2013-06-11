class CapturesController < ApplicationController
  
  def index
    @title = "Captures"
    
    @start_date = Time.parse(Time.new.strftime("%Y-%m-%d"))
    @end_date = @start_date
    
    # Check which submit button was used
    if(params[:commit].eql?("This Week"))
      @end_date += 604800
    elsif(params[:commit].eql?("Today"))
      @end_date += 86400
    else
      #Check params for correctness
      if !(params[:start_date].nil? || params[:start_date].empty?)
        @start_date = Time.parse(params[:start_date])
      end
      
      #default end_date to a week from start_date
      if (params[:end_date].nil? || params[:end_date].empty?)
        @end_date = @start_date + 604800
      else
        @end_date = Time.parse(params[:end_date])
      end
    end
  end

end
