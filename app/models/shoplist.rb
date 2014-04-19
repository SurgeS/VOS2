class Shoplist < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name

  has_many :item_in_lists, dependent: :destroy
  has_many :products, through: :item_in_lists
end
