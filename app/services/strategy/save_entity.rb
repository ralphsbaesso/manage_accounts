module Strategy
  class SaveEntity < AStrategy

    def process

      p entity

      if status == :green
        entity.save

        if entity.errors.present?
          entity.errors.full_messages.each do |error|
            messages << error
          end
          set_status :red
          return false
        end
      else
        set_status :red
        return false
      end

      true
    end

  end
end