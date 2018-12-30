module RuleMap
  class RuleMapAccount

    @@strategies = []

    def self.insert
      @@strategies << Strategy::CheckExistEntity
      @@strategies << Strategy::SaveEntity
    end

    def self.delete
      @@strategies << Strategy::CheckExistAssociationToItem
    end

    def self.update
      @@strategies << Strategy::CheckEqualsNameEntityToUpdate
    end
  end
end