class EventsController < ApplicationController
  def index
    respond_to do |format|
      if !!params[:date]
        results = Hash.new
        results["todays_stats"] = Array.new
        
        queryResults = Event.select("event_type, COUNT(event_type)").where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).group(:event_type)
        queryResults.each do |obj| 
          results["todays_stats"].push({obj.event_type => obj.count})
        end
        
        format.json { render :json => results }
      else 
        @events = Event.all
        format.json { render :json => @events }
      end 
    end
  end
  
  def create
    @events = Event.create!(formatted_post_params)

    respond_to do |format|
      if @events.save
        format.json {  render :show, status: :created  } 
      else 
        format.json { render :json => @events.errors } 
      end
    end
  end


  #to accept objects without "name" and "event_type" as keys, move the other
  #passed in params to be filed under "other_params" 
  def formatted_post_params
    result = Hash.new
    result["other_params"] = Hash.new

    all_post_params = params.permit!

    all_post_params.each do |key, value|
      if (key == "name" || key == "event_type")
        result[key] = value
      else 
        # passed in params that aren't "name" or "event_type" aren't going under
        # the :event key, sort through the remainder
        if (!["controller", "action", "event"].include? key)
          result["other_params"][key] = value
        end
      end
    end

    return result
  end

  # def query_string_object
  #   request.query_parameters

end