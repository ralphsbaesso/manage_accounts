module RuleMap
  class RuleMapItem

    def self.insert
      [
          Strategy::CheckExistEntity,
          Strategy::SaveEntity
      ]
    end

    def self.delete
      [
          Strategy::CheckExistAssociationToItem,
      ]
    end

    def self.update
      [
          Strategy::CheckEqualsNameEntityToUpdate,
      ]
    end
  end
end