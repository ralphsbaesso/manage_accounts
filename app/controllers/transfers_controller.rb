class TransfersController < AuthenticateBaseController
  before_action :initialize_variables, only: [:index, :create, :edit, :new, :update]
  before_action :set_transfer, only: [:destroy]
  before_action :set_facade, only: [:index, :create, :update, :destroy, :pie_chart]

  def index
    transaction_all
  end

  def new
    @transaction = Transaction.new
  end

  def edit
    @transaction = Transaction.find_by(id: params[:id])
    @selected_account_id = @transaction.account_id

    associated = @transaction.associated_transaction
    if associated
      @selected_destination_account_id = associated.account.id
    end

    @selected_subitem = @transaction.subitem
    if @selected_subitem
      @selected_item = @selected_subitem.item

      @selected_subitem_id = @selected_subitem.id
      @selected_item_id = @selected_subitem.item_id
    end

  end

  def create
    @origin_transaction = Transaction.new(transaction_params)

    transfer = Transfer.new
    transfer.origin_transaction = @origin_transaction
    if params[:destiny_account_id].present?
      @destiny_transaction = Transaction.new(account_id: params[:destiny_account_id])
      transfer.destiny_transaction = @destiny_transaction
    end

    transporter = @facade.insert(transfer)

    if transporter.status == :green
      @transaction = Transaction.new
      flash[:notice] = 'Transação gravada'
      if params[:commit].include? 'nova'
        redirect_to action: :new
      else
        redirect_to action: :index, filter: filter_from_session, page: page_from_session, per_page: per_page_from_session
      end
    else
      @transaction = @origin_transaction
      @selected_account_id = @origin_transaction.account
      @selected_destination_account_id = @destiny_transaction.account.id if @destiny_transaction
      flash[:error] = transporter.messages
      render :new
    end
    
  end

  def update

    current_transaction = Transaction.find(params[:id])
    @transfer = Transfer.find(params[:transfer_id])

    map = {
        current_transaction: current_transaction,
        attributes_orgin: transaction_params,
    }
    map[:attributes_destiny] = { account_id: params[:destiny_account_id] } if params[:destiny_account_id].present?

    transporter = @facade.update @transfer, map

    if transporter.status == :green
      flash[:notice] = 'Transação atualizada!'
      redirect_to action: :index, filter: filter_from_session, page: page_from_session, per_page: per_page_from_session
    else
      transaction_params.each do |key, value|
        current_transaction[key] = value
      end
      @transaction = current_transaction
      @selected_account_id = @transaction.account_id
      associated = @transaction.associated_transaction
      @selected_destination_account_id = associated.account.id if associated
      flash[:error] = transporter.messages
      render :edit
    end
  end

  def destroy

    transporter = @facade.delete @transfer

    if transporter.status == :green
      flash[:notice] = 'Transação deletada'
      redirect_to action: :index, filter: filter_from_session, page: page_from_session, per_page: per_page_from_session
    else
      flash[:error] = transporter.messages
      render :index
    end
  end

  def pie_chart
    @transporter = @facade.select(:transfer, filter: filter_params || {}, pie_chart: true)
    data = @transporter.bucket[:data]
    @positives = data[:positives]
    @negatives = data[:negatives]
  end

  private

  def initialize_variables

    @selected_account_id = nil
    @selected_destination_account_id = nil
    @array_accounts = [['','']] + current_accountant.accounts.collect { |a| [a.name, a.id] }
    @destination_accounts = @array_accounts

    @errors = []
    @errors << 'Deve existir pelo menos uma conta.' unless current_accountant.accounts.present?
    @errors << 'Deve existir pelo menos um item.' unless current_accountant.items.present?
    @errors << 'Deve existir pelo menos um subitem.' unless current_accountant.subitems.present?

  end

  def transaction_params
    params.require(:transaction).permit(:date_transaction, :price, :description, :title, :amount, :subitem_id, :account_id, :ignore)
  end

  def filter_params
    filter[:start_date] = Date.today.beginning_of_month unless filter[:start_date].present?
    filter[:end_date] = Date.today.end_of_month unless filter[:end_date].present?
    filter
  end

  def set_transfer
    @transfer = Transfer.find(params[:id])
  end

  def transaction_all
    transporter = @facade.select(:transfer, filter: filter_params)
    @transactions = transporter.bucket[:transactions].page(page).per(per_page)
    cookies[:filter] = @filter.to_json
  end

  def set_facade
    @facade ||= Facade.new(current_accountant)
  end

end
