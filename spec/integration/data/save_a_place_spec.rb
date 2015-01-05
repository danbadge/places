require 'spec_helper'
require 'rails_helper'

describe 'storing a place in the database' do

  it 'should generate an id' do
  	place = Place.new
	place.name = 'place name'
	place.latitude = 52.1111111
	place.longitude = 8.999219
	place.rating = 5.5
	place.place_type = 'cafe,pub,life'
	place.google_place_id = 'googleplaceid'
	place.save!

	expect(place.id).not_to be_nil
	expect(place.id).to satisfy { |id| id > 0 }
  end

  it 'should store correct values' do
  	place = Place.new
	place.name = 'place 1 2 3'
	place.latitude = 99.1111111
	place.longitude = 83.999219
	place.rating = 2.2
	place.place_type = 'cats,life'
	place.google_place_id = 'googleplaceid123'
	place.save!

	stored_place = Place.find(place.id)

	expect(stored_place.name).to eq(place.name)
	expect(stored_place.latitude).to eq(place.latitude)
	expect(stored_place.longitude).to eq(place.longitude)
	expect(stored_place.rating).to eq(place.rating)
	expect(stored_place.place_type).to eq(place.place_type)
	expect(stored_place.google_place_id).to eq(place.google_place_id)
  end
end
