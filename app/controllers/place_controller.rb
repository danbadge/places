class PlaceController < ApplicationController
  skip_before_action :verify_authenticity_token

  def post
    place_params = params['place']
    #place = Place.new(:google_place_id => place_params[""])
    #place.save!
    respond_to do |format|
      google_place_id = place_params['google_place_id']
      format.json { render json: place_params, status: 201, location: "#{root_url}place/#{google_place_id}" }
    end
  end
end