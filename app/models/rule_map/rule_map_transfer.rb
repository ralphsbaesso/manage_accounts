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

    def self.select
      [
          Strategy::StrategyTransfer::Filter
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
          Strategy::StrategyTransfer::SetAttributesTransactions,
          Strategy::StrategyTransfer::CheckTransactions,
          Strategy::StrategyTransfer::CheckAccounts,
          Strategy::StrategyTransfer::TransferDataBetweenAccounts,
          Strategy::StrategyTransfer::UpdateTransfer,
      ]
    end
  end
end