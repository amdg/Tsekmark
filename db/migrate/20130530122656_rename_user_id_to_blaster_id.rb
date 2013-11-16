class RenameUserIdToBlasterId < ActiveRecord::Migration
  def up
    rename_column :blasts, :user_id, :blaster_id
    add_column :blasts, :blaster_type, :string
  end

  def down
    rename_column :blasts, :blaster_id, :user_id
    remove_column :blasts, :blaster_type
  end
end
