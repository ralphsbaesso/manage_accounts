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

    @subitem = Subitem.new(subitem_params)
    transporter = @facade.insert(@subitem)

    if transporter.status == :green
      flash[:notice] = 'Subitem criado com sucesso'
      redirect_to action: :index
    else
      flash[:error] = transporter.messages
      render :new
    end
  end

  def update

    transporter = @facade.update @subitem, attributes: subitem_params

    if transporter.status == :green
      flash[:notice] = 'Subitem atualizado com sucesso!'
      redirect_to action: :index
    else
      flash[:error] = transporter.messages
      render :edit
    end
  end

  def destroy
    transporter = @facade.delete @subitem

    if transporter.status == :green
      flash[:notice] = 'Subitem deletado com sucesso'
      redirect_to action: :index
    else
      flash[:error] = transporter.messages
      render :index
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
