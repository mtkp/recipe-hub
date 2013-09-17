class DirectionsController < ApplicationController
  include CurrentRecipe
  before_action :set_editable_recipe
  before_action :set_direction, only: [:show, :edit, :update, :destroy]

  # GET /directions/new
  def new
    @direction = Direction.new
  end

  # GET /directions/1/edit
  def edit
  end

  # POST /directions
  # POST /directions.json
  def create
    @direction = @recipe.directions.build(direction_params)

    respond_to do |format|
      if @direction.append_to_list
        format.html { redirect_to @recipe, notice: 'Direction was successfully created.' }
        format.json { render action: 'show', status: :created, location: @direction }
      else
        format.html { render action: 'new' }
        format.json { render json: @direction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /directions/1
  # PATCH/PUT /directions/1.json
  def update
    respond_to do |format|
      if @direction.update(direction_params)
        format.html { redirect_to @recipe, notice: 'Direction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @direction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /directions/1
  # DELETE /directions/1.json
  def destroy
    respond_to do |format|
      if @direction.remove_from_list
        format.html { redirect_to @recipe }
        format.json { head :no_content }
      else
        format.html { redirect_to @recipe, notice: 'Direction could not be deleted' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_direction
      @direction = @recipe.directions.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access non-existant or unauthorized direction"
      redirect_to @recipe, alert: "Direction was not found."
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def direction_params
      params.require(:direction).permit(:body)
    end
end
