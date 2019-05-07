module RuleMap
  class RuleTransfer

    def self.insert(transporter)
      [
          Strategy::Transfers::CheckTransactions.new(transporter),
          Strategy::Transfers::CheckAccounts.new(transporter),
          Strategy::Transfers::TransferDataBetweenAccounts.new(transporter),
          Strategy::Transfers::SetOriginTransaction.new(transporter),
          Strategy::SaveEntity.new(transporter),
      ]
    end

    def self.select(transporter)
      [
          Strategy::Transfers::Filter.new(transporter),
      ]
    end

    def self.delete(transporter)
      [
          Strategy::DestroyEntity.new(transporter),
      ]
    end

    def self.update(transporter)
      [
          Strategy::Transfers::CheckDisassociate.new(transporter),
          Strategy::Transfers::SetAttributesTransactions.new(transporter),
          Strategy::Transfers::CheckTransactions.new(transporter),
          Strategy::Transfers::CheckAccounts.new(transporter),
          Strategy::Transfers::TransferDataBetweenAccounts.new(transporter),
          Strategy::Transfers::UpdateTransfer.new(transporter),
      ]
    end
  end
end