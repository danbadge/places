class SearchController < ApplicationController
  def get
    searchTerm = params[:q]
    searchForPlaces = SearchForPlaces.new
    places = searchForPlaces.find(searchTerm)
    respond_to do |format|
      format.json { render json: places }
    end
  end
end