class RuleMapItem

  @@strategies = []

  def self.insert

    @@strategies << CheckExistItem
  end
end