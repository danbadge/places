class MapController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  before_filter :setup_google_api

  def setup_google_api
    @google_api = PlaceDetails.new()
  end

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
    return @google_api.get_place(id)
  end
end
