class AddSectorToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :sector_code, :string, limit: 10
    add_column :departments, :sector_name, :string, limit: 100
  end
end
