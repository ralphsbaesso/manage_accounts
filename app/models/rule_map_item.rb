require 'strategy/check_exist_item'

class RuleMapItem

  @@strategies = []

  def self.insert

    @@strategies << CheckExistItem
  end
end