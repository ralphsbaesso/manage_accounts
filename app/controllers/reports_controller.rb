class ReportsController < AuthenticateBaseController
  before_action :set_facade, only: [:pie_chart, :line]

  def pie_chart

    @transporter = @facade.select(:report, filter: filter_params || {}, pie_chart: true)
    data = @transporter.bucket[:data]

    @positives = data[:positives]
    @negatives = data[:negatives]

  end

  def line
    @transporter = @facade.select(:report, filter: filter_params || {}, line_chart: true)
    @data = @transporter.bucket[:data]
    @data

  end

  private

  def filter_params

    @filter = {}
    if params[:filter]
      filter = params.require(:filter).permit(:subitem_id, :item_id, :account_id, :start_date, :end_date)
      filter[:start_date] = filter[:start_date].present? ? Date.parse(filter[:start_date]) : nil
      filter[:end_date] = filter[:end_date].present? ? Date.parse(filter[:end_date]) : nil
    end

    if filter.present?
      filter.each do |k, v|
        @filter[k.to_sym] = v if v.present?
      end
    end
    @filter
  end

  def set_facade
    @facade ||= Facade.new(current_accountant)
  end

end
