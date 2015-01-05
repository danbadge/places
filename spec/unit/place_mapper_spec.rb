require 'spec_helper'
require 'rails_helper'

describe 'mapping a place from a hash' do
	it 'should map the correct values' do
		place_params = { 'name' => 'place name',
										 'google_place_id' => 'G00GL3ID',
										 'place_type' => 'place,types',
										 'rating' => 4.3,
										 'latitude' => 89.4345334,
										 'longitude' => -0.021312 }

		mapped_place = PlaceMapper.new().from(place_params)

		expect(mapped_place.name).to match('place name')
		expect(mapped_place.google_place_id).to match('G00GL3ID')
		expect(mapped_place.place_type).to match('place,types')
		expect(mapped_place.rating).to match(4.3)
		expect(mapped_place.latitude).eql?(89.4345334)
		expect(mapped_place.longitude).eql?(0.021312)
		expect(mapped_place.id).to be_nil
	end
end
