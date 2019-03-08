module RuleMap
  class RuleMapSubitem

    def self.insert
      [
          Strategy::CheckExistEntity,
          Strategy::SaveEntity
      ]
    end

    def self.update
      [
          Strategy::CheckEqualsNameEntityToUpdate,
          Strategy::UpdateEntity
      ]
    end

    def self.delete
      [
          Strategy::CheckAssociation,
          Strategy::DestroyEntity
      ]
    end
  end
end