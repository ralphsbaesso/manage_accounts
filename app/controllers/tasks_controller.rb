class TasksController < ApplicationController
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

    p = task_params
    p[:done] = false
    @task = Task.new(p)
  
    @task.accountant = current_accountant
  
    @transporter = Facade.insert @task, current_accountant
  
    respond_to do |format|
      if @transporter.status == 'GREEN'
        flash[:notice] = 'Task criado.'
        task_all
        format.html { render :index }
      else
        format.html { render :new }
      end
    end
  end
  
  def update
  
    @transporter = Facade.update @task, attributes: task_params
  
    respond_to do |format|
      if @transporter.status == 'GREEN'
        flash[:notice] = 'Task atualizado.!'
        format.html { redirect_to action: :index }
      else
        format.html { render :edit, task: @task }
      end
    end
  end
  
  def destroy
  
    @transporter = Facade.delete @task
  
    respond_to do |format|
      if @transporter.status == 'GREEN'
        flash[:notice] = 'Tarefa deletada'
        format.html { redirect_to action: :index }
      else
        task_all
        format.html { render :index }
      end
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
      params.require(:task).permit(:id, :name, :description, :due_date, :type, :done)
    else
      params.permit(:id, :name, :description)
    end
  end
  
  def task_all
    @tasks = Task.where(accountant_id: current_accountant.id)
  end
  
end
