class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy]

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

    @transporter = Facade.insert @item

    respond_to do |format|
      if @transporter.status == 'GREEN'
        flash[:notice] = 'Item criado com sucesso'
        item_all
        format.html { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def update

    @transporter = Facade.update @item, attributes: item_params

    respond_to do |format|
      if @transporter.status == 'GREEN'
        flash[:notice] = 'Item atualizado com sucesso!'
        format.html { redirect_to action: :index }
      else
        format.html { render :edit, item: @item }
      end
    end
  end

  def destroy

    @transporter = Facade.delete @item

    respond_to do |format|
      if @transporter.status == 'GREEN'
        format.html { redirect_to action: :index, notice: 'Item deletado com sucesso' }
      else
        item_all
        format.html { render :index }
      end
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
      @items = Item.where(accountant_id: current_accountant.id)
    end
end
