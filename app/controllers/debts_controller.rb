class DebtsController < AuthenticateBaseController
  before_action :set_facade, only: [:index, :create, :update, :destroy]
  before_action :set_task, only: [:edit, :update, :destroy]
  
  def index
    task_all
  end
  
  def new
    @task = Task.new
  end
  
  def edit
  end
  
  def create

    debt = task_params
    debt[:done] = false
    debt[:task_type] = :debt
    @task = Task.new(debt)
  
    @task.accountant = current_accountant
  
    transporter = @facade.insert @task
  
    if transporter.status == :green
      flash[:notice] = 'Task criado.'
      redirect_to action: :index
    else
      flash[:error] = transporter.messages
      render :new
    end
  end
  
  def update
  
    transporter = @facade.update @task, attributes: task_params
  
    if transporter.status == :green
      flash[:notice] = 'Task atualizado.!'
      redirect_to action: :index
    else
      flash[:error] = transporter.messages
      render :edit
    end
  end
  
  def destroy
  
    transporter = @facade.delete @task
  
    if transporter.status == :green
      flash[:notice] = 'Tarefa deletada'
      redirect_to action: :index
    else
      flash[:error] = transporter.messages
      redirect_to action: :index
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    if params[:task].present?
      params.require(:task).permit(:id, :name, :description, :due_date, :task_type, :done)
    else
      params.permit(:id, :name, :description)
    end
  end
  
  def task_all
    transporter = @facade.select(:task, task_type: :debt)
    @tasks = transporter.bucket[:tasks]
  end

  def set_facade
    @facade ||= Facade.new(current_accountant)
  end
  
end
