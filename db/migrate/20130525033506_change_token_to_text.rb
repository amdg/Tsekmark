class ChangeTokenToText < ActiveRecord::Migration
  def up
    change_column :authentications, :token, :text
  end

  def down
    change_column :authentications, :token, :string, :limit => 150
  end
end
