class SearchForPlaces
  def initialize
    @api_key = "AIzaSyA6ww-54JxL_krZ0VyA5cCS8ALCgEowhss"
    @base_url = "https://maps.googleapis.com/maps/api/"
    @endpoint = "place/nearbysearch/json?"
  end

  def find(searchTerm)
    if (searchTerm.size == 0)
      return Array.new
    end

    params = {
        keyword: searchTerm,
        key: @api_key,
        location: '51.511918,-0.127501',
        radius: 5000,
        rankby: 'prominence',
        types: 'restaurant|food|bar'
    }

    request = @base_url + @endpoint + params.to_query
    puts request
    response = HTTParty.get(request)
    puts response.code, response["status"]

    google_results = response["results"]

    places = Array.new

    google_results.each do |result|
      place = Place.new()
      place.name = result["name"]
      location = result["geometry"]["location"]
      place.latitude = location["lat"]
      place.longitude = location["lng"]
      place.rating = result["rating"]
      place.place_type = result["types"].join(",")
      place.google_place_id = result["place_id"]
      place.address = result['vicinity']

      places.push(place)
    end
    places
  end
end