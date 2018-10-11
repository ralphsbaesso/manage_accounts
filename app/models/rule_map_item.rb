require 'strategy/check_exist_item'
require 'strategy/check_exist_association'
require 'strategy/check_equals_name_item_to_update'
require 'strategy/save_item'

class RuleMapItem

  @@strategies = []

  def self.insert
    @@strategies << CheckExistItem
    @@strategies << SaveItem
  end

  def self.delete
    @@strategies << CheckExistAssociation
  end

  def self.update
    @@strategies << CheckEqualsNameItemToUpdate
  end
end