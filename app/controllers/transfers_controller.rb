class TransfersController < AuthenticateBaseController
  before_action :initialize_variables, only: [:index, :create, :edit, :new, :update]
  before_action :set_transfer, only: [:destroy]
  before_action :set_facade, only: [:index, :create, :update, :destroy]

  def index
    transaction_all
  end

  def new
    @transaction = Transaction.new
  end

  def edit
    @transaction = Transaction.find_by(id: params[:id])
    @account_selected = @transaction.account

    associated = @transaction.associated_transaction
    if associated
      @destination_account_selected = associated.account
    end

    @subitem_selected = @transaction.subitem
    @item_selected = @subitem_selected.item

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
        redirect_to action: :index
      end
    else
      @transaction = @origin_transaction
      @account_selected = @origin_transaction.account
      @destination_account_selected = @destiny_transaction.account if @destiny_transaction
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
      redirect_to action: :index
    else
      transaction_params.each do |key, value|
        current_transaction[key] = value
      end
      @transaction = current_transaction
      account = @transaction.account
      @account_selected = [account.name, account.id]
      associated = @transaction.associated_transaction
      if associated
        destination_account = associated.account
        @destination_account_selected = [destination_account.name, destination_account.id]
      end
      flash[:error] = transporter.messages
      render :edit
    end
  end

  def destroy

    transporter = @facade.delete @transfer

    if transporter.status == :green
      flash[:notice] = 'Transação deletada'
      redirect_to action: :index
    else
      flash[:error] = transporter.messages
      render :index
    end
  end

  private

  def initialize_variables

    @account_selected = nil
    @destination_account_selected = nil
    @array_accounts = [['','']] + current_accountant.accounts.collect { |a| [a.name, a.id] }
    @destination_accounts = @array_accounts

    @errors = []
    @errors << 'Deve existir pelo menos uma conta.' unless current_accountant.accounts.present?
    @errors << 'Deve existir pelo menos um item.' unless current_accountant.items.present?
    @errors << 'Deve existir pelo menos um subitem.' unless current_accountant.subitems.present?

  end

  def transaction_params
    params.require(:transaction).permit(:date_transaction, :value, :description, :title, :amount, :subitem_id, :account_id)
  end

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

  def set_transfer
    @transfer = Transfer.find(params[:id])
  end

  def transaction_all
    transporter = @facade.select(Transfer.new, filter: filter_params || {})
    @transactions = transporter.bucket[:transactions]
  end

  def set_facade
    @facade ||= Facade.new(current_accountant)
  end

end
