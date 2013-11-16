include Grape::Entity::DSL

class Department < ActiveRecord::Base
  has_many :owners
  has_many :general_appropriations, :source => :general_appropriations, :through => :owners

  entity :id, :code, :name

end
