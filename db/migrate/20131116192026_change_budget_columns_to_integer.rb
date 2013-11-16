class ChangeBudgetColumnsToInteger < ActiveRecord::Migration
  def up
    change_column :general_appropriations, :budget_ps, :integer
    change_column :general_appropriations, :budget_mooe, :integer
    change_column :general_appropriations, :budget_co, :integer
  end

  def down
    change_column :general_appropriations, :budget_ps, :decimal, precision: 2
    change_column :general_appropriations, :budget_mooe, :decimal, precision: 2
    change_column :general_appropriations, :budget_co, :decimal, precision: 2
  end
end
