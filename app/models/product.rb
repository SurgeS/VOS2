class Product < ActiveRecord::Base
  validates_presence_of :name, :price, :shop
  validates :name, uniqueness: {scope:  :shop}
end
