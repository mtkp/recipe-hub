class DirectionsController < ApplicationController
  include CurrentRecipe
  before_action :set_editable_recipe
  before_action :set_direction, only: [:show, :edit, :update, :destroy]

  def new
    @direction = Direction.new
    respond_to do |format|
      format.html
      format.js { render template: 'shared/new_item', locals: { item: @direction } }
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js { render template: 'shared/edit_item', locals: { item: @direction } }
    end
  end

  def create
    @direction = @recipe.directions.build(direction_params)

    respond_to do |format|
      if @direction.append_to_list
        format.html { redirect_to @recipe, notice: 'Direction was successfully created.' }
        format.js { render template: 'shared/create_item', locals: { item: @direction } }
        format.json { render action: 'show', status: :created, location: @direction }
      else
        format.html { render action: 'new' }
        format.js { render template: 'shared/new_item', locals: { item: @direction } }
        format.json { render json: @direction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @direction.update(direction_params)
        format.html { redirect_to @recipe, notice: 'Direction was successfully updated.' }
        format.js { render template: 'shared/update_item', locals: { item: @direction } }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.js { render template: 'shared/edit_item', locals: { item: @direction } }
        format.json { render json: @direction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @direction.remove_from_list
        format.html { redirect_to @recipe }
        format.js { render template: 'shared/destroy_item', locals: { item: @direction } }
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
