class CreateGeneralAppropriations < ActiveRecord::Migration
  def change
    create_table :general_appropriations do |t|
      t.integer :year, limit: 4
      t.string :code, limit: 20
      t.string :description
      t.decimal :budget_ps, precision: 2
      t.decimal :budget_mooe, precision: 2
      t.decimal :budget_co, precision: 2
      t.references :owner
      t.references :area
      t.timestamps
    end
  end
end
