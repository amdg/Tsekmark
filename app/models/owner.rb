class Owner < ActiveRecord::Base
  belongs_to :department

  # TODO Fix agency classification field (implement enum or change to string)
end
