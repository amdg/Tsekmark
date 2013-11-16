class GeneralAppropriation < ActiveRecord::Base
  belongs_to :owner
  belongs_to :area
  # attr_accessible :title, :body
end
