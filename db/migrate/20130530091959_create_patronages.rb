class CreatePatronages < ActiveRecord::Migration
  def change
    create_table :patronages do |t|
      t.integer :business_id
      t.integer :user_id
      t.timestamps
    end
  end
end

