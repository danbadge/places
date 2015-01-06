class MapController < ApplicationController
  def index
  	@places = Array.new

  	Place.all.each do |place|
      @places.push(place)
  	end

  	return @places
  end
end
