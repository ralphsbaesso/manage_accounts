class SaveEntity < AStrategy

  def self.process(transporter)


    if transporter.status == 'GREEN'
      entity = transporter.entity
      entity.save

      if entity.errors.present?
        entity.errors.full_messages.each do |erro|
          transporter.messages << erro
        end
        transporter.status = 'RED'
        return false
      end
    end

    false
  end

end