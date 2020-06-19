class EventsController < ApplicationController
  def index
    @events = Event.all
    render :json => @events
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

end