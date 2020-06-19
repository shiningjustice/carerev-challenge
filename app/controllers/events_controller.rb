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

  def formatted_post_params
    result = Hash.new
    result["other_params"] = Hash.new
    all_post_params = params.require(:event).permit!

    all_post_params.each do |key, value|
      if (key == "name" || key == "event_type")
        result[key] = value
      else
        result["other_params"][key] = value
      end
    end

    return result
  end

end