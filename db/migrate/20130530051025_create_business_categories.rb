class CreateBusinessCategories < ActiveRecord::Migration
  def change
    create_table :business_categories do |t|
      t.string :name, limit: 100
    end
  end
end
