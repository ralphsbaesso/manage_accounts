class AccountsController < AuthenticateBaseController
  before_action :set_account, only: [:edit, :update, :destroy]
  before_action :set_facade, only: [:index, :create, :update, :destroy, :line_chart]

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

    transporter = @facade.insert @account, current_accountant

    if transporter.status == :green
      flash[:notice] = 'Conta criado.'
      redirect_to action: :index
    else
      flash[:error] = transporter.messages
      render :new
    end
  end

  def update

    transporter = @facade.update @account, attributes: account_params

    if transporter.status == :green
      flash[:notice] = 'conta atualizada.'
      redirect_to action: :index
    else
      flash[:error] = transporter.messages
      render :edit, account: @account
    end
  end

  def destroy
    transporter = @facade.delete @account

    if transporter.status == :green
      flash[:notice] = 'Conta deletada.'
      redirect_to action: :index
    else
      flash[:error] = transporter.messages
      redirect_to action: :index
    end
  end

  def line_chart
    @filter = {}
    @transporter = @facade.select(:account, filter: {}, line_chart: true)
    @data = @transporter.bucket[:data]
    @data
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:name, :description, :header_file)
  end

  def account_all
    @accounts = Account.where(accountant_id: current_accountant.id)
  end

  def set_facade
    @facade ||= Facade.new(current_accountant)
  end
end
