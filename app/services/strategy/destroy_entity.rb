class Strategy::DestroyEntity < AStrategy

  def process

    if status == 'GREEN'
      entity.destroy

      if entity.errors.present?
        entity.errors.full_messages.each do |error|
          messages << error
        end
        set_status 'RED'
        return false
      end

    else
      set_status 'RED'
    end

    false
  end

end