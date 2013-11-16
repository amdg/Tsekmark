class AddMoreColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, :limit => 50 unless column_exists?(:users, :first_name)
    add_column :users, :last_name, :string, :limit => 50 unless column_exists?(:users, :last_name)
    add_column :users, :date_of_birth, :date unless column_exists?(:users, :date_of_birth)
    remove_column :users, :name if column_exists?(:users, :name)
  end
end

