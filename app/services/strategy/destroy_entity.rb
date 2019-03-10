class Strategy::DestroyEntity < AStrategy

  def process

    if status == :green
      entity.destroy

      if entity.errors.present?
        entity.errors.full_messages.each do |error|
          messages << error
        end
        set_status :red
        return false
      end

    else
      set_status :red
    end

    false
  end

end