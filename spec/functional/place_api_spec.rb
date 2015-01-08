require 'spec_helper'
require 'rails_helper'


describe 'When adding a place to the list' do
  it 'should return 201 created' do
    response = add_place('g00glepl4ceid')

    expect(response.code).to eq(201)
    expect(response.headers['location']).to match(/http:\/\/localhost:3000\/place\/\d+/)

    delete_place(response['id'])
  end
end

describe 'when adding an existing place to the list' do
  it 'should not be duplicated and return 302 Found' do
    first_response = add_place('thisisanid')
    first_place_id = first_response['id']

    second_response = add_place('thisisanid')
    second_place_id = second_response['id']

    expect(first_place_id).to eq(second_place_id)
    expect(second_response.code).to eq(200)

    delete_place(first_place_id)
  end
end

def add_place(google_id)
  HTTParty.post('http://localhost:3000/place',
                           :body => { :google_place_id => google_id,
                                      :name => 'test place',
                                      :latitude => 1234.78,
                                      :longitude => 456.89,
                                      :rating => 5.5,
                                      :place_type => 'these,are,types'
                           }.to_json,
                           :headers => { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } )
end

def delete_place(place_id)
  HTTParty.post("http://localhost:3000/place/#{place_id}/delete", { :follow_redirects => false })
end

describe 'When removing a place from the list' do
  it 'should be achievable via POST method which redirects to index' do
    response = HTTParty.post('http://localhost:3000/place/12345/delete', { :follow_redirects => false })

    expect(response.code).to eq(302)
    expect(response.headers['location']).to eq('http://localhost:3000/')
  end
end
