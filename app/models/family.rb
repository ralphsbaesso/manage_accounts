class Family < ApplicationRecord
  has_many :accountants, autosave: true
end
