class MapController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def index
  	@places = Array.new

  	Place.all.each do |place|
  		if !place.google_place_id.to_s.empty?
  			begin
  				@places.push(get_place(place.google_place_id))
  			rescue
  				#do nothing
  			end
  		end
  	end
  	return @places
  end

  def create
  	place_id = params[:google_place_id]
  	puts place_id
  	if place_id.to_s.empty?
  		raise Error.new()
  	else
		place = Place.new(:google_place_id => place_id)
		place.save!
		@message = "THIS TOTALLY WORKED"
  	end
  end

  def get_place(id)
  	api_key = "AIzaSyA6ww-54JxL_krZ0VyA5cCS8ALCgEowhss"
  	request = "https://maps.googleapis.com/maps/api/place/details/json?placeid=#{id}&key=#{api_key}"
  	response = HTTParty.get(request)
  	
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
