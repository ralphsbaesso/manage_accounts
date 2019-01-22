class TransfersController < ApplicationController
  before_action :initialize_variables, only: [:create, :edit, :new, :update]
  before_action :set_transfer, only: [:destroy]

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
    associated = @transaction.associated_transaction
    if associated
      destination_account = associated.account
      @destination_account_selected = [destination_account.name, destination_account.id]
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

    current_transaction = Transaction.find(params[:id])
    @transfer = Transfer.find(params[:transfer_id])

    map = {
        current_transaction: current_transaction,
        attributes_orgin: transaction_params,
    }
    map[:attributes_destiny] = { account_id: params[:destiny_account_id] } if params[:destiny_account_id].present?

    @transporter = Facade.update @transfer, map

    respond_to do |format|
      if @transporter.status == 'GREEN'
        flash[:notice] = 'Transação atualizada!'
        format.html { redirect_to action: :index }
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
        format.html { render :edit }
      end
    end
  end

  def destroy

    @transporter = Facade.delete @transfer

    respond_to do |format|
      if @transporter.status == 'GREEN'
        format.html { redirect_to action: :index, notice: 'Transação deletado.' }
      else
        transaction_all
        format.html { render :index }
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
    list = []
    current_accountant.accounts.each do |account|
      list += Transaction.where(account_id: account.id)
    end
    @transactions = list.sort_by { |value| value[:date_transaction]}
  end

  def set_transfer
    @transfer = Transfer.find(params[:id])
  end

end
