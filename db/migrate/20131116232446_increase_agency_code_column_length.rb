class IncreaseAgencyCodeColumnLength < ActiveRecord::Migration
  def change
    change_column :owners, :code, :string, limit: 20
  end
end
