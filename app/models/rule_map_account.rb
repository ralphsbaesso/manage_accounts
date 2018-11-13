require 'strategy/check_exist_entity'
require 'strategy/check_exist_association'
require 'strategy/check_equals_name_item_to_update'
require 'strategy/save_entity'

class RuleMapAccount

  @@strategies = []

  def self.insert
    @@strategies << CheckExistEntity
    @@strategies << SaveEntity
  end

  def self.delete
    @@strategies << CheckExistAssociation
  end

  def self.update
    @@strategies << CheckEqualsNameItemToUpdate
  end
end