module AccountsHelper

  def options_for_select_header_file(selected=nil, **options)
    array = [
      [t('helpers.account.header_file.date_description_ignore_value'), :date_description_ignore_value],
      [t('helpers.account.header_file.date_description_value'), :date_description_value],
      [t('helpers.account.header_file.ignore_date_doc_description_value_symbol'),:ignore_date_doc_description_value_symbol],
    ]

    array.unshift(['','']) if options[:first_blank]
    options_for_select(array, selected)
  end
end
