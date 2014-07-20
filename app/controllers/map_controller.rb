class MapController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def index
  	@places = Array.new

  	Place.all.each do |place|
  		if !place.google_place_id.to_s.empty?
  			begin
  				@places.push(get_place(place.google_place_id))
  			rescue StandardError
  				#do nothing
  			end
  		end
  	end
  	return @places
  end

  def add
  end

  def create
  	place_id = params[:place][:google_place_id]
  	
  	if place_id.to_s.empty?
  		render :status => :bad_request, :text => "Google's Place Id was empty, please try again."
      return
  	end

    begin 
      get_place(place_id)
    rescue StandardError => error
      render :status => :bad_request, :text => error.message
      return
    end
		place = Place.new(:google_place_id => place_id)
    place.save!
		redirect_to :controller => "map", :action => "index"
  end

  def get_place(id)
  	api_key = "AIzaSyA6ww-54JxL_krZ0VyA5cCS8ALCgEowhss"
  	request = "https://maps.googleapis.com/maps/api/place/details/json?placeid=#{id}&key=#{api_key}"
  	
    response = HTTParty.get(request)
    puts response.code, response["status"]

    unless response.code == 200 && response["status"] == "OK"
      fail StandardError, "Could not find Google Place with Id: #{id}"
    end
  	
    place_details = response["result"]

  	place = Place.new()
  	place.name = place_details["name"]
  	location = place_details["geometry"]["location"]
  	place.latitude = location["lat"]
  	place.longitude = location["lng"]
  	place.rating = place_details["rating"]
  	place.place_type = ''

  	place_details["types"].each do |type|
  		if place.place_type.to_s.length > 0 
  			place.place_type = place.place_type + ", "
		end
  		place.place_type = place.place_type + "#{type}"
	end
	return place
  end
end
