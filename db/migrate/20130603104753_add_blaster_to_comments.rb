class AddBlasterToComments < ActiveRecord::Migration
  def change
    add_column :comments, :blaster_type, :string
    add_column :comments, :blaster_id, :integer
  end
end
