class CreateBlasts < ActiveRecord::Migration
  def change
    create_table :blasts do |t|
      t.belongs_to :user
      t.belongs_to :location
      t.string :body
      t.timestamps
    end
  end
end
