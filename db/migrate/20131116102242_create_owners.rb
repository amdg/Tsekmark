class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.references :department
      t.string :code, limit: 10
      t.string :name, limit: 100
      t.integer :type, limit: 1
    end
  end
end
