class SubitemsController < AuthenticateBaseController
  before_action :set_subitem, only: [:edit, :update, :destroy]
  before_action :set_facade, only: [:index, :create, :update, :destroy]

  def index
    subitem_all
  end

  def new
    @subitem = Subitem.new
  end

  def edit
  end

  def create
    
    @transporter = @facade.insert(@subitem, attributes: subitem_params)

    if @transporter.status == 'GREEN'
      flash[:notice] = 'Subitem criado com sucesso'
      subitem_all
      render :index
    else
      render :new
    end
  end

  def update

    @transporter = @facade.update @subitem, attributes: subitem_params

    respond_to do |format|
      if @transporter.status == 'GREEN'
        flash[:notice] = 'Subitem atualizado com sucesso!'
        format.html { redirect_to action: :index }
      else
        format.html { render :edit, subitem: @subitem }
      end
    end
  end

  def destroy
    @transporter = @facade.delete @subitem

    respond_to do |format|
      if @transporter.status == 'GREEN'
        format.html { redirect_to action: :index, notice: 'Subtem deletado com sucesso' }
      else
        format.html { render :index }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_subitem
    @subitem = Subitem.find(params[:id])
  end

  def subitem_params
    params.require(:subitem).permit(:name, :description, :level, :account_type, :item_id)
  end

  def subitem_all
    subitems = []
    current_accountant.items.each do |item|
      item.subitems.each do |subitem|
        subitems << subitem
      end
    end
    @subitems = subitems.sort_by { |sub| sub.name }
  end

  def set_facade
    @facade ||= Facade.new(current_accountant)
  end

end
