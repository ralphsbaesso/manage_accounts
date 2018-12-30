class Strategy::CheckExistAssociationToSubitem < AStrategy

  def self.process(transporter)

    subitem = transporter.entity

    subitem = Transaction.joins(:subitem).where('subitem.id': subitem.id)

    if subitem.present?
      transporter.messages << 'Esse subitem está associado a uma TRANSAÇÃO, por tanto não poderá ser apagado!'
      transporter.status = 'RED'
      return false
    end

    true

  end
end