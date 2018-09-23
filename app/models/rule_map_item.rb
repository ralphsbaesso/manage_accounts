require 'strategy/check_exist_item'
require 'strategy/check_exist_association'
require 'strategy/check_equals_name_item_to_update'

class RuleMapItem

  @@strategies = []

  def self.insert
    @@strategies << CheckExistItem
  end

  def self.delete
    @@strategies << CheckExistAssociation
  end

  def self.update
    @@strategies << CheckEqualsNameItemToUpdate
  end
end