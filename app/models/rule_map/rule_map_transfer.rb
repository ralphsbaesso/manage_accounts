module RuleMap
  class RuleMapTransfer

    def self.insert
      [
          Strategy::StrategyTransfer::CheckTransactions,
          Strategy::StrategyTransfer::CheckAccounts,
          Strategy::StrategyTransfer::TransferDataBetweenAccounts,
          Strategy::StrategyTransfer::SetOriginTransaction,
          Strategy::SaveEntity
      ]
    end

    def self.delete
      [
          Strategy::DestroyEntity
      ]
    end

    def self.update
      [
          Strategy::StrategyTransfer::CheckDisassociate,
          Strategy::StrategyTransfer::CheckTransactions,
          Strategy::StrategyTransfer::CheckAccounts,
          Strategy::StrategyTransfer::TransferDataBetweenAccounts,
      ]
    end
  end
end