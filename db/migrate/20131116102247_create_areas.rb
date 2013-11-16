class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :code, limit: 10
      t.string :name, limit: 100
    end
  end
end
