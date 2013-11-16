class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.belongs_to :blaster
      t.string :blaster_type, :limit => 75
      t.string :name
      t.string :email, :limit => 150
      t.string :provider, :limit => 50
      t.string :provider_uid, :limit => 50
      t.timestamps
    end
  end
end
