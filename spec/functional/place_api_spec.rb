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
    expect(response.headers['location']).to match(/http:\/\/localhost:3000\/place\/\d+/)
  end
end

describe 'When removing a place from the list' do
  it 'should be achievable via POST method which redirects to index' do
    response = HTTParty.post('http://localhost:3000/place/12345/delete', { :follow_redirects => false })

    expect(response.code).to eq(302)
    expect(response.headers['location']).to eq('http://localhost:3000/')
  end
end
