class MapController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  before_filter :setup_google_api

  def setup_google_api
    @google_api = PlaceDetails.new()
  end

  def index
  	Place.all
  end

  def get_place(id)
    return @google_api.get_place(id)
  end
end
