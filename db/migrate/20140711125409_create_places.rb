class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.decimal :longitude
      t.decimal :latitude
      t.string :type
      t.decimal :rating

      t.timestamps
    end
  end
end
