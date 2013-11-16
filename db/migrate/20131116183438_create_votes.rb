class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :user
      t.text :comment
      t.integer :vote_type, :default => 0
      t.references :general_appropriation
      t.timestamps
    end

    add_attachment :votes, :photo
  end
end
