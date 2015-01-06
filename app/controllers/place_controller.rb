class PlaceController < ApplicationController
  skip_before_action :verify_authenticity_token

  def post
    place_params = params['place']
    place = PlaceMapper.new().from(place_params)
    place.save!
    respond_to do |format|
      format.json { render json: place_params, status: 201, location: "#{root_url}place/#{place.id}" }
    end
  end

  def delete
    Place.delete(params['id'])
    redirect_to action: 'index', controller: 'map'
  end
end