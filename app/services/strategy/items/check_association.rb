module Strategy
  module Items
    class CheckAssociation < AStrategy

      def process

        item = entity

        subitem = Subitem.joins(:item).where('items.id': item.id)

        if subitem.present?
          add_message 'Esse item está associado a um SUBITEM, por tanto não poderá ser apagado!'
          set_status :red
          return false
        end

        true

      end
    end
  end
end