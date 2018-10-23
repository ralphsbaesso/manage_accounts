class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :destroy]

  def index
    item_all
  end

  def show
    redirect_to action: :index
  end

  def new
    @item = Item.new
  end

  # GET /items/1/edit
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

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update

    @item = Item.new(item_params)
    @transporter = Facade.update @item

    respond_to do |format|
      if @transporter.status == 'GREEN'
        flash[:notice] = 'Item atualizado com sucesso!'
        format.html {
          redirect_to action: :index
        }
      else
        format.html { render :edit }
      end
    end
  end


  def destroy

    @transporter = Facade.delete @item

    respond_to do |format|
      if @transporter.status == 'GREEN'
        format.html { redirect_to @item, action: :show, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :index }
        format.js { render :error }
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
      @items = Item.all
    end
end
