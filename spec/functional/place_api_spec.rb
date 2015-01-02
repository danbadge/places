require 'spec_helper'
require 'rails_helper'


describe 'When adding a place to the list' do
  it 'should return 201 created' do
    response = HTTParty.post('http://localhost:3000/place',
                  :body => { :google_place_id => 'g00glepl4ceid',
                             :name => 'test place',
                             :latitude => 1234.78,
                             :longitude => 456.89,
                             :rating => 5.5,
                             :place_type => 'these,are,types'
                  }.to_json,
                  :headers => { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } )

    expect(response.code).to eq(201)
  end

  it 'should return a location to a resource which can then be retrieved' do
    google_place = {
        :google_place_id => 'g00glepl4ceid',
        :name => 'test place',
        :latitude => 1234.78,
        :longitude => 456.89,
        :rating => 5.5,
        :place_type => 'these,are,types'
    }

    post_response = HTTParty.post('http://localhost:3000/place',
                             :body => google_place.to_json,
                             :headers => { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } )

    location = post_response.headers['location']

    get_response = HTTParty.get(location, :headers => { 'Accept' => 'application/json' })

    expect(get_response.code).to eq(200)

    google_place['id'] = location.sub('http://localhost:3000/place/', '')
    expect(get_response.body).to eq(google_place.to_json)
  end
end
