class MapController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def index
  	@places = Array.new

  	@places.push(Place.new(name:"Dock Kitchen",latitude: 51.526608,longitude: -0.21522,rating: 3.9, place_type:"restaurant"))
  	@places.push(Place.new(name:"DSTRKT",latitude: 51.510398,longitude: -0.132361,rating: 4.1, place_type:"restaurant"))
  	@places.push(Place.new(name:"Steam & Rye",latitude: 51.513477,longitude: -0.08319,rating: 4.1, place_type:"restaurant"))
  	@places.push(Place.new(name:"The Ledbury",latitude: 51.516684,longitude: -0.200064,rating: 4.6, place_type:"restaurant"))
  end

  def create
  	place_id = params[:placeId]

  	place = Place.new(:google_place_id => @place_id)
	place.save!
  end
end
