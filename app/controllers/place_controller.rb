class PlaceController < ApplicationController
  skip_before_action :verify_authenticity_token

  def post
  	place = request.body.to_json
    respond_to do |format|
      format.json { render json: place, status: 201, location: 'http://localhost:3000/place/' + place['google_place_id'] }
    end
  end
end