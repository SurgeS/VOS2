class Price < ActiveRecord::Base
  validates_presence_of :price, :shop

  belongs_to :product
end
