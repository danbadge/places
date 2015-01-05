require 'spec_helper'
require 'rails_helper'


describe 'index page' do
  it 'should return all places' do
  	place = Place.new
  	place.save!

  	controller = MapController.new

  	places = controller.index

  	expect(places.size).to be > 0
  	expect(places).to include(place)
  	expect(places).to be_a_kind_of(Array)
  end
end