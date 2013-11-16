class AddBlasterTypeToAthentication < ActiveRecord::Migration
  def up
    rename_column :authentications, :user_id, :blaster_id
    add_column :authentications, :blaster_type, :string
  end

  def down
    rename_column :authentications, :blaster_id, :user_id
    remove_column :authentications, :blaster_type
  end
end
