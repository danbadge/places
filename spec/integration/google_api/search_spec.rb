require 'spec_helper'
require 'rails_helper'

describe 'searching for a place using google api' do

  it 'should return a google place id, name, types, rating and location' do
    searchForPlaces = SearchForPlaces.new
    places = searchForPlaces.find('the ledbury')
    place = places[0]
    expect(place.name).to eq('The Ledbury')
    expect(place.google_place_id).to eq('ChIJe29QNB0QdkgR5Kkx_0-jdo4')
    expect(place.longitude).to eq(-0.200106)
    expect(place.latitude).to eq(51.516618)
    expect(place.place_type).to eq("bar,restaurant,food,establishment")
    expect(place.rating).to eq(4.7)
  end

  it 'should return multiple places' do
    searchForPlaces = SearchForPlaces.new
    places = searchForPlaces.find('kings head')
    expect(places.size).to be > 1
  end

  it 'should return no places when search term is empty' do
    searchForPlaces = SearchForPlaces.new
    places = searchForPlaces.find('')
    expect(places.size).to eq(0)
  end

end