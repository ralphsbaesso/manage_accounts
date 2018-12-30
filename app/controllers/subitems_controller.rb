class SubitemsController < ApplicationController
  before_action :set_subitem, only: [:edit, :update, :destroy]

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
    
    @transporter = Facade.insert(@subitem)

    respond_to do |format|
      if @transporter.status == 'GREEN'
        flash[:notice] = 'Subitem criado com sucesso'
        item_all
        format.html { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def update

    @transporter = Facade.update @item, attributes: subitem_params

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
    @transporter = Facade.delete @subitem

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
end
