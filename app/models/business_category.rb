class BusinessCategory < ActiveRecord::Base
  extend FriendlyId

  has_many :businesses
  attr_accessible :name

  friendly_id :name

  def self.all_categories
    Rails.cache.fetch("business-categories", :expires_in => 1.day) do
      self.all
    end
  end

  def self.search(term='')
    BusinessCategory.find_by_sql("
      SELECT DISTINCT name, id
      FROM business_categories
      WHERE name LIKE '#{term}%';
    ")
  end

  def to_s
    self.name
  end
end