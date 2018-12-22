module RuleMap
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
end