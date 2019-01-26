module SharedHelper

  def format_date(value, options={})

    value.strftime('%d/%m/%y') if value
  end

  def options_for_select_accounts(options={})

    selected = options[:selected]
    first_blank = options[:first_blank]

    accounts = current_accountant.accounts
    array = accounts.to_a
    array = [Account.new] + array if first_blank
    options_for_select(array.collect { |a| [a.name, a.id] }, selected)
  end

  def options_for_select_items(options= {})

    selected = options[:selected]
    first_blank = options[:first_blank]

    @items = current_accountant.items
    array = @items.to_a
    array = [Item.new] + array if first_blank
    @first_blanck = first_blank # para utilizar no metodo dynamic_select_items_subitems
    options_for_select(array.collect { |a| [a.name, a.id] }, selected)
  end

  def options_for_select_subitems(options={})

    return raise 'Primeiro selecione "options_for_select_items"' unless @items

    selected = options[:selected]
    first_blank = options[:first_blank]

    subitems = @items.first.subitems
    array = subitems.to_a
    array = [Subitem.new] + array if first_blank
    options_for_select(array.collect { |a| [a.name, a.id] }, selected)
  end

  def dynamic_select_items_subitems
    selects = {''=> '<options></options>'}

    @subitems = current_accountant.subitems
    return raise 'Para utilizar este méthodo tem que chamar antes os methodos: [options_for_select_items, options_for_select_subitems]' if @items.nil? or @subitems.nil?

    @items.each do |item|
      subitems = @subitems.select { |subitem| subitem.item_id == item.id }
      array = subitems.to_a
      array = [Subitem.new] + array if @first_blanck
      selects[item.id] = options_for_select(array.collect { |a| [a.name, a.id] }).gsub(/\"/, '').gsub(/\n/, '')
    end

    javascript = <<-EOF
      <script>
        var selects_subitems = JSON.parse('#{selects.to_json}');
    
        $('#transaction_item_id').change(function() {
          var id = this.value
          $('#transaction_subitem_id').html(selects_subitems[id]);
        })
      </script>
    EOF

    javascript.html_safe

  end

end