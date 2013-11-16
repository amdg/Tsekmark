class CreateCityLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :country_code, limit: 10
      t.string :region
      t.integer :population
      t.float :latitude
      t.float :longitude
      t.string :combined
      t.timestamps
    end
    add_index :locations, :combined
  end
end
