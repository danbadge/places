require 'HTTParty'
require 'spec_helper'
require 'rails_helper'

describe 'Adding a place to the list' do

  it 'should return 201 and a location to the resource' do
    response = HTTParty.post('http://localhost:3000/place',
                  :body => { :google_place_id => 'google_place_id',
                             :name => 'test place',
                             :latitude => 1234.78,
                             :longitude => 456.89,
                             :rating => 5.5,
                             :place_type => 'these,are,types'
                  }.to_json,
                  :headers => { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } )

    expect(response.code).to eq(201)
    expect(response.headers['location']).to eq('http://localhost:3000/place/google_place_id')
  end
end
