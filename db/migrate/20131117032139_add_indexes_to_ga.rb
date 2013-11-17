class AddIndexesToGa < ActiveRecord::Migration
  def change
    add_index :general_appropriations, [:owner_id]
    add_index :general_appropriations, [:area_id]
  end
end
