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
  end

  def create
    @transaction = Transaction.new(transaction_params)
    transfer = Transfer.new

    p params
  end

  private


  def transaction_params
    params.require(:transaction).permit(:date_transaction, :value, :description, :title, :amount, :subitem_id)
  end

end
