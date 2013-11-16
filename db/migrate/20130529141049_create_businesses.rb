class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.belongs_to :user
      t.belongs_to :location
      t.belongs_to :business_category
      t.string :name, limit: 150, null: false
      t.string :phone, limit: 15
      t.string :fax, limit: 15
      t.string :website, limit: 100
      t.string :email, limit: 120
      t.string :address1, limit: 50
      t.string :address2, limit: 50
      t.string :postal_code, limit: 25
      t.string :description
      t.text :product_services
      t.text :specialties
      t.text :brands
      t.boolean :verified
      t.float :longitude
      t.float :latitude
      t.timestamps
    end
  end
end
