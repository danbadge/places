class PlaceDetails
	def initialize
		@api_key = 'AIzaSyA6ww-54JxL_krZ0VyA5cCS8ALCgEowhss'
		@base_url = 'https://maps.googleapis.com/maps/api/'
		@endpoint = 'place/details/json'
	end

	def get_place(id)
		request = @base_url + @endpoint + "?placeid=#{id}&key=#{@api_key}"
		response = HTTParty.get(request)
		puts response.code, response['status']
		fail StandardError, "Could not find Google Place with Id: #{id}" unless response.code == 200 && response["status"] == "OK"

		place_details = response['result']

		place = Place.new()
		place.name = place_details['name']
		place.google_place_id = place_details['place_id']
		location = place_details['geometry']['location']
		place.latitude = location['lat']
		place.longitude = location['lng']
		place.rating = place_details['rating']
		place.place_type = place_details['types'].join(',')

		return place
	end

end