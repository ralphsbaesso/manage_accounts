class TransfersController < ApplicationController
  before_action :initialize_variables, only: [:create, :edit, :new]

  def index
    transaction_all
  end

  def new
    @transaction = Transaction.new
  end

  def edit
    @transaction = Transaction.find_by(id: params[:id])
    account = @transaction.account
    @account_selected = [account.name, account.id]
    destination_account = @transaction.transfer.destiny_transaction.account if @transaction.transfer.destiny_transaction
    @destination_account_selected = [destination_account.name, destination_account.id] if destination_account
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
        @account_selected = [@origin_transaction.account.name, @origin_transaction.account.id]
        @destination_account_selected = [@destiny_transaction.account.name, @destiny_transaction.account.id] if @destiny_transaction
        format.html { render :new }
      end
    end
  end

  def update

    @transporter = Facade.update @item, attributes: item_params

    respond_to do |format|
      if @transporter.status == 'GREEN'
        flash[:notice] = 'Item atualizado.!'
        format.html { redirect_to action: :index }
      else
        format.html { render :edit, item: @item }
      end
    end
  end

  private

  def initialize_variables

    @account_selected = nil
    @destination_account_selected = nil
    @array_accounts = [['','']] + current_accountant.accounts.collect { |a| [a.name, a.id] }
    @items = current_accountant.items
    @hash_subitems = {}
    @items.each do |item|
      @hash_subitems[item.id] = item.subitems
    end
    @destination_accounts = @array_accounts

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
