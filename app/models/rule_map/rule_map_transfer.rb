module RuleMap
  class RuleMapTransfer

    def self.insert
      [
          Strategy::StrategyTransfer::CheckTransactions,
          Strategy::StrategyTransfer::CheckAccounts,
          Strategy::SaveEntity
      ]
    end

    def self.delete
    end

    def self.update
    end
  end
end