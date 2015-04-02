class Doctrine < ActiveRecord::Base

  has_many :roles
  has_and_belongs_to_many :roles
end
