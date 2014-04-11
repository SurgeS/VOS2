class Product < ActiveRecord::Base
  validates_presence_of :name
  validates :name, uniqueness: true

  has_many :prices
end
