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
          Strategy::DestroyEntity
      ]
    end

    def self.update
      [
          Strategy::CheckEqualsNameEntityToUpdate
      ]
    end
  end
end