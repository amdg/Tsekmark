class AddTwitterUidToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :twitter_uid, :string, limit: 100
  end
end
