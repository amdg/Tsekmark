class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.belongs_to :user
      t.string :token, null: false, limit: 150
      t.string :secret, limit: 150
      t.string :provider, null: false, limit: 50
      t.string :uid, null: false, limit: 50
      t.timestamps
    end

    add_index :authentications, [:user_id, :provider], :unique => true unless index_exists?(:authentications, [:user_id, :provider])
  end
end
