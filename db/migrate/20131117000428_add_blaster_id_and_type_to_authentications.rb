class AddBlasterIdAndTypeToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :blaster_id, :integer
    add_column :authentications, :blaster_type, :string
    remove_column :authentications, :user_id
  end
end
