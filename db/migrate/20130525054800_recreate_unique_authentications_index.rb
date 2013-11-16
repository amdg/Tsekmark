class RecreateUniqueAuthenticationsIndex < ActiveRecord::Migration
  def up
    remove_index :authentications, [:user_id, :provider] if index_exists?(:authentications, [:user_id, :provider])
    add_index :authentications, [:user_id, :provider, :uid], :unique => true unless index_exists?(:authentications, [:user_id, :provider, :uid])
  end

  def down
    remove_index :authentications, [:user_id, :provider, :uid] if index_exists?(:authentications, [:user_id, :provider, :uid])
    add_index :authentications, [:user_id, :provider], :unique => true unless index_exists?(:authentications, [:user_id, :provider])
  end
end
