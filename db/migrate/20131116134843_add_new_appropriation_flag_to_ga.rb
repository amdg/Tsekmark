class AddNewAppropriationFlagToGa < ActiveRecord::Migration
  def change
    add_column :general_appropriations, :new_appropriation, :boolean
  end
end
