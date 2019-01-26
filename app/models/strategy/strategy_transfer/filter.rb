module Strategy::StrategyTransfer
  class Filter < AStrategy

    def self.process(transporter)

      transfer = transporter.entity

      return false unless transfer.is_a? Transfer

      filter = transporter.bucket[:filter]
      accountant = transporter.current_accountant

      query = { account_id: accountant.account_ids }

      date = filter[:date] || Date.today

      start_date = date.beginning_of_month
      end_date = date.end_of_month
      query[:date_transaction] = (start_date..end_date)


      if filter[:subitem_id].present?
        query[:subitem_id] = filter[:subitem_id]
      elsif filter[:item_id].present?
        subitem_ids = Subitem.where(item_id: filter[:item_id]).map { |subitem| subitem.id }
        query[:subitem_id] = subitem_ids
      end

      account_id = filter[:account_id] || filter['account_id']
      query[:account_id] = account_id if account_id.present?

      transporter.bucket[:transactions] = Transaction.where(query).order(:date_transaction).page(filter[:page]).per(filter[:per])

      true


    end
  end

end