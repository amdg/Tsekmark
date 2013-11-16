class AddPhotoToBusiness < ActiveRecord::Migration
  def self.up
    add_attachment :businesses, :photo
  end

  def self.down
    remove_attachment :businesses, :photo
  end
end
