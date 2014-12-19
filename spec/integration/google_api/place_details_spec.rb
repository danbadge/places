require 'spec_helper'
require 'rails_helper'

describe 'retrieving a place from google api' do

  it 'should return the correct values' do
    placesApi = PlaceDetails.new()
    placeId = 'ChIJe29QNB0QdkgR5Kkx_0-jdo4'
    place = placesApi.get_place(placeId)

    expect(place).to be_a_kind_of(Place)
    expect(place.google_place_id).to eq(placeId)
    expect(place.name).to eq('The Ledbury')
    expect(place.longitude).to eq(-0.200106)
    expect(place.latitude).to eq(51.516618)
    expect(place.place_type).to eq("bar,restaurant,food,establishment")
    expect(place.rating).to eq(4.7)
  end

  it 'should return not found error if place does not exist' do
    placesApi = PlaceDetails.new()
    expect { placesApi.get_place('id_that_does_not_exist') }.to raise_error(StandardError, /Could not find Google Place with Id:/)
  end
end