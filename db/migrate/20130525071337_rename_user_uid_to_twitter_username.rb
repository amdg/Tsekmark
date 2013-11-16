class RenameUserUidToTwitterUsername < ActiveRecord::Migration
  def up
    rename_column :users, :uid, :twitter_uid
  end

  def down
    rename_column :users, :twitter_uid, :uid
  end
end
