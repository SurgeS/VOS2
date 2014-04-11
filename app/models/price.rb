class Price < ActiveRecord::Base
  validates_presence_of :price, :shop
  validates_numericality_of :price, greater_than: 0

  #pridat ficuru: ak najde rovnake, zmaz starsie
  #validates :product_id, uniqueness: {scope: [:price, :shop]}

  belongs_to :product
end
