class MoveSectorToAgency < ActiveRecord::Migration
  def up
    remove_column :departments, :sector_code
    remove_column :departments, :sector_name

    add_column :owners, :sector_code, :string, limit: 10
    add_column :owners, :sector_name, :string, limit: 100
  end

  def down
    remove_column :owners, :sector_code
    remove_column :owners, :sector_name

    add_column :departments, :sector_code, :string, limit: 10
    add_column :departments, :sector_name, :string, limit: 100
  end
end
