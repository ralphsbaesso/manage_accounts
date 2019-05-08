class BankStatementsController < AuthenticateBaseController
  before_action :set_facade, only: [:create]


  def new

  end


  def create

    file = params[:extract]

    bank_statement = BankStatement.new
    bank_statement.account = Account.find(params[:account_id])
    bank_statement.last_extract.attach(io: file.tempfile, filename: File.basename(file.tempfile.path))
    bank_statement.pay_date = params[:pay_date]

    transporter = @facade.insert(bank_statement)

    if transporter.status == :green
      flash[:notice] = 'Arquivo salvo com sucesso!'
      redirect_to action: :new
    else
      flash[:error] = transporter.messages
      render :new
    end
    
  end

  def set_facade
    @facade ||= Facade.new(current_accountant)
  end

end
