class SaveItem < AStrategy

  def self.process(transporter)


    if transporter.status == 'GREEN'
      item = transporter.entity
      item.save

      if item.errors.present?
        item.errors.full_messages.each do |erro|
          transporter.messages << erro
        end
        transporter.status = 'RED'
        return false
      end
    end

    false
  end

end