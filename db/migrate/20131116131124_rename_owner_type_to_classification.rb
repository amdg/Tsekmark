class RenameOwnerTypeToClassification < ActiveRecord::Migration
  def up
    rename_column :owners, :type, :classification
  end

  def down
    rename_column :owners, :classification, :type
  end
end
