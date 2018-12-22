class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    account_all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
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

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    hash = account_params
    hash[:accountant_id] = current_accountant.id
    respond_to do |format|
      flash[:notice] = 'conta atualizada com sucesso'
      if @account.update(hash)
        format.html { render :index }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
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