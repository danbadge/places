class PlaceController < ApplicationController
  skip_before_action :verify_authenticity_token

  def post
    place_params = params['place']
    place = PlaceMapper.new().from(place_params)
    existing_place = Place.find_by_google_place_id(place.google_place_id)
    if existing_place.nil?
      http_status_code = 201
      place.save!
    else
      http_status_code = 200
      place.id = existing_place.id
    end

    place_params[:id] = place.id
    respond_to do |format|
      format.json { render json: place_params, status: http_status_code, location: "#{root_url}place/#{place.id}" }
    end
  end

  def delete
    Place.delete(params['id'])
    redirect_to action: 'index', controller: 'map'
  end
end