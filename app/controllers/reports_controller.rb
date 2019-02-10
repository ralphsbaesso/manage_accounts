class ReportsController < AuthenticateBaseController
  before_action :set_facade, only: [:transfers]

  def transfers

    @transporter = @facade.select(Transfer.new, filter: filter_params || {}, format: :pie_chart)
    data = @transporter.bucket[:data]

    @positives = data[:positives]
    @negatives = data[:negatives]


  end

  private

  def filter_params

    filter = { page: params[:page] || 1, per: params[:per] || 10 }
    if params[:filter]
      f = params.require(:filter).permit(:subitem_id, :item_id, :account_id)
      year = params[:filter][:year]
      month = Util::Month.number_by_name params[:filter][:month]
      date = Date.parse("#{year}-#{month}-01")
      f[:date] = date
    end
    if f.present?
      f.each do |k, v|
        filter[k.to_sym] = v
      end
    end
    filter
  end

  def set_facade
    @facade ||= Facade.new(current_accountant)
  end

end
