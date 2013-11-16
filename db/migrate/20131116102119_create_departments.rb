class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :code, limit: 10
      t.string :name, limit: 100
    end
  end
end
