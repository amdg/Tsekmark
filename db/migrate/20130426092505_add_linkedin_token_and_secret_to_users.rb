class AddLinkedinTokenAndSecretToUsers < ActiveRecord::Migration
  def change
    add_column :users, :linkedin_token, :string, :limit => 50 unless column_exists?(:users, :linkedin_token)
    add_column :users, :linkedin_secret, :string, :limit => 50 unless column_exists?(:users, :linkedin_secret)
  end
end
