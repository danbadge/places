# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task :insert_test_data do
  placesUrl = 'http://localhost:3000/place'
  google_ids = ['ChIJh2qoUSsbdkgR3aewc17VVIg', 'ChIJe29QNB0QdkgR5Kkx_0-jdo4', 'ChIJM6-5BjUbdkgRqMHRVeI8d3o', 'ChIJwzr1dCwbdkgRL3za-ese_Dg', 'ChIJZ-YVItMEdkgR2_qjlApBJ1w', 'ChIJGf1tvVIDdkgRi2F7MYycglc']
  google_ids.each do |google_id|
    puts 'POST ' + placesUrl + ' body:place[google_place_id]=' + google_id
    response = HTTParty.post(placesUrl, :body => {'place[google_place_id]' => google_id })
    puts 'RESPONSE ' + response.code.to_s + ' - ' + response.body
  end
end