class Owner < ActiveRecord::Base
  belongs_to :department
  # attr_accessible :title, :body
end
