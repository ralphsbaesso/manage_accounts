class AccountantsController < AuthenticateBaseController
  before_action :set_accountant, only: [:show, :edit, :update, :destroy, :show]
  before_action :authenticate_accountant!

  def index
    @accountants = Accountant.all
  end

  def new
    @accountant = Accountant.new
  end

  def edit
  end

  def create
    @accountant = Accountant.new(accountant_params)

    respond_to do |format|
      if @accountant.save
        format.html { redirect_to @accountant, notice: 'Accountant was successfully created.' }
        format.json { render :show, status: :created, location: @accountant }
      else
        format.html { render :new }
        format.json { render json: @accountant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accountants/1
  # PATCH/PUT /accountants/1.json
  def update
    respond_to do |format|
      if @accountant.update(accountant_params)
        format.html { redirect_to @accountant, notice: 'Accountant was successfully updated.' }
        format.json { render :show, status: :ok, location: @accountant }
      else
        format.html { render :edit }
        format.json { render json: @accountant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accountants/1
  # DELETE /accountants/1.json
  def destroy
    @accountant.destroy
    respond_to do |format|
      format.html { redirect_to accountants_url, notice: 'Accountant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accountant
      @accountant = Accountant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accountant_params
      params.require(:accountant).permit(:name, :description, :id)
    end
end
