class ItemsController < AuthenticateBaseController
  before_action :set_item, only: [:edit, :update, :destroy]
  before_action :set_facade, only: [:index, :create, :update, :destroy]

  def index
    item_all
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create

    @item = Item.new(item_params)

    @item.accountant = current_accountant

    transporter = @facade.insert @item

    if transporter.status == :green
      flash[:notice] = 'Item criado.'
      redirect_to action: :index
    else
      flash[:error] = transporter.messages
      render :new
    end
  end

  def update

    transporter = @facade.update @item, attributes: item_params

    if transporter.status == :green
      flash[:notice] = 'Item atualizado.!'
      redirect_to action: :index
    else
      flash[:error] = transporter.messages
      render :edit, item: @item
    end
  end

  def destroy

    transporter = @facade.delete @item

    if transporter.status == 'GREEN'
      redirect_to action: :index, notice: 'Item deletado.'
    else
      flash[:error] = transporter.messages
      redirect_to action: :index
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    if params[:item].present?
      params.require(:item).permit(:id, :name, :description)
    else
      params.permit(:id, :name, :description)
    end
  end

  def item_all
    @items = Item.where(accountant_id: current_accountant.id).order(:name)
  end

  def set_facade
    @facade ||= Facade.new(current_accountant)
  end
end
