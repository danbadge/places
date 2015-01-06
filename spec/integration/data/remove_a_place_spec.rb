require 'spec_helper'
require 'rails_helper'

describe 'Removing a place from the database' do

  it 'should be removed permanently' do
    place = Place.new
    place.save!

    Place.delete(place.id)

    places = Place.all
    expect(places).to_not include(place)
  end
end