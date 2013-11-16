include Grape::Entity::DSL

class Owner < ActiveRecord::Base
  belongs_to :department
  has_many :general_appropriations

  entity :id, :department_id, :code, :name, :classification  do
    expose :department, :using => Department::Entity
  end


end
