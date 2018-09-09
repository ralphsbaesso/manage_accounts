class Item < ApplicationRecord

  belongs_to :accountant

  has_many :subitem
end
