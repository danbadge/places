class SearchController < ApplicationController
  def get
    search_term = params[:q]
    search_for_places = SearchForPlaces.new
    places = search_for_places.find(search_term)
    respond_to do |format|
      format.json { render json: places }
    end
  end
end