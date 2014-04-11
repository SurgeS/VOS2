class Price < ActiveRecord::Base
  validates_presence_of :price, :shop

  validates :product_id, uniqueness: {scope: [:price, :shop]}
  belongs_to :product
end
