class AccountsController < ApplicationController
  before_action :set_account, only: [:edit, :update, :destroy]

  def index
    account_all
  end

  def new
    @account = Account.new
  end

  def edit
  end

  def create

    @account = Account.new(account_params)

    @account.accountant = current_accountant

    @transporter = Facade.insert @account

    respond_to do |format|
      if @transporter.status == 'GREEN'
        account_all
        flash[:notice] = 'Conta criado com sucesso'
        format.html { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def update

    @transporter = Facade.update @account, account_params

    respond_to do |format|
      if @transporter.status == 'GREEN'
        flash[:notice] = 'conta atualizada com sucesso'
        format.html { redirect_to action: :index }
      else
        format.html { render :edit, account: @account }
      end
    end
  end

  def destroy
    @transporter = Facade.delete @account

    respond_to do |format|
      if @transporter.status == 'GREEN'
        format.html { redirect_to action: :index, notice: 'Conta deletada com sucesso' }
      else
        format.html { render :index }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:name)
    end

    def account_all
      @accounts = Account.where(accountant_id: current_accountant.id)
    end
end
