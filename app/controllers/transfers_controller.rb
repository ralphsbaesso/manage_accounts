class TransfersController < ApplicationController
  before_action :set_transfer, only: [:show, :edit, :update, :destroy]

  def new
    @transaction = Transaction.new
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

  def create
    @origin_transaction = Transaction.new(transaction_params)
    transfer = Transfer.new
    transfer.origin_transaction = @origin_transaction
    if params[:destiny_account_id]
      @destiny_transaction = Transaction.new(account_id: params[:destiny_account_id])
      transfer.destiny_transaction = @destiny_transaction
    end

    r = Facade.insert(transfer)

    p r
    redirect_to action: :new
  end

  private


  def transaction_params
    params.require(:transaction).permit(:date_transaction, :value, :description, :title, :amount, :subitem_id, :account_id)
  end

end
