class Location < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :country_code, :region, :population, :latitude, :longitude, :combined

  has_many :blasts
  has_many :users
  has_many :businesses

  friendly_id :combined, use: :slugged

  def self.search(term='')
    Location.find_by_sql("
      SELECT DISTINCT combined, latitude, longitude, id
      FROM locations
      WHERE combined LIKE '#{term}%';
    ")
  end

  def to_s
    self.combined
  end

end
