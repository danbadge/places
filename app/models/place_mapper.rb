class PlaceMapper
  def from(place_hash)
    Place.new(:name => place_hash['name'],
              :google_place_id => place_hash['google_place_id'],
              :rating => place_hash['rating'],
              :latitude => place_hash['latitude'],
              :longitude => place_hash['longitude'],
              :place_type => place_hash['place_type'])
  end
end