class AccountsController < AuthenticateBaseController
  before_action :set_account, only: [:edit, :update, :destroy]
  before_action :set_facade, only: [:index, :create, :update, :destroy]

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

    @transporter = @facade.insert @account, current_accountant

    respond_to do |format|
      if @transporter.status == 'GREEN'
        account_all
        flash[:notice] = 'Conta criado.'
        format.html { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def update

    @transporter = @facade.update @account, attributes: account_params

    respond_to do |format|
      if @transporter.status == 'GREEN'
        flash[:notice] = 'conta atualizada.'
        format.html { redirect_to action: :index }
      else
        format.html { render :edit, account: @account }
      end
    end
  end

  def destroy
    flash[:notice] = 'Metodo não implementado'
    redirect_to action: :index
    # @transporter = @facade.delete @account

    # if @transporter.status == 'GREEN'
    #   redirect_to action: :index, notice: 'Conta deletada.'
    # else
    #   render :index
    # end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:name, :description)
  end

  def account_all
    @accounts = Account.where(accountant_id: current_accountant.id)
  end

  def set_facade
    @facade ||= Facade.new(current_accountant)
  end
end
