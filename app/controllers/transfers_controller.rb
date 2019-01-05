class TransfersController < ApplicationController
  before_action :set_transfer, only: [:show, :edit, :update, :destroy]

  def index
    transaction_all
  end

  def new
    @transaction = Transaction.new
    initialize_variables
  end

  def create
    @origin_transaction = Transaction.new(transaction_params)

    transfer = Transfer.new
    transfer.origin_transaction = @origin_transaction
    if params[:destiny_account_id].present?
      @destiny_transaction = Transaction.new(account_id: params[:destiny_account_id])
      transfer.destiny_transaction = @destiny_transaction
    end

    @transporter = Facade.insert(transfer)
    initialize_variables

    respond_to do |format|
      if @transporter.status == 'GREEN'
        @transaction = Transaction.new
        flash[:notice] = 'Transação gravada'
        if params[:commit].include? 'nova'
          format.html { render :new }
        else
          transaction_all
          format.html { render :index }
        end
      else
        @transaction = @origin_transaction
        format.html { render :new }
      end
    end
  end

  private

  def initialize_variables

    @array_accounts = current_accountant.accounts.collect { |a| [a.name, a.id] }
    @items = current_accountant.items
    @hash_subitems = {}
    @items.each do |item|
      @hash_subitems[item.id] = item.subitems
    end
    @destination_accounts = [['','']] + @array_accounts

    @errors = []
    @errors << 'Deve existir pelo menos uma conta.' unless current_accountant.accounts.present?
    @errors << 'Deve existir pelo menos um item.' unless current_accountant.items.present?
    @errors << 'Deve existir pelo menos um subitem.' unless @hash_subitems.present?

  end


  def transaction_params
    params.require(:transaction).permit(:date_transaction, :value, :description, :title, :amount, :subitem_id, :account_id)
  end

  def transaction_all
    @transactions = []
    current_accountant.accounts.each do |account|
      @transactions += Transaction.where(account_id: account.id)
    end
    @transactions
  end

end
