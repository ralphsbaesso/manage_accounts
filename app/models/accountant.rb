class Accountant < ApplicationRecord

  has_many :accounts

  has_many :items

end
