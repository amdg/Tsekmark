include Grape::Entity::DSL

class Area < ActiveRecord::Base
  has_many :general_appropriations

  entity :id, :code, :name
end
