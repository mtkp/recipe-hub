class IngredientsController < ApplicationController
  include CurrentRecipe
  before_action :set_editable_recipe
  before_action :set_ingredient, except: [:new, :create]

  def new
    @ingredient = Ingredient.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end

  def create
    @ingredient = @recipe.ingredients.build(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to @recipe, notice: 'Ingredient was successfully created.' }
        format.js
        format.json { render action: 'show', status: :created, location: @ingredient }
      else
        format.html { render action: 'new' }
        format.js { render action: 'new' }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to @recipe, notice: 'Ingredient was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to @recipe }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = @recipe.ingredients.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access non-existant or unauthorized ingredient"
      redirect_to @recipe, alert: "Ingredient was not found."
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_params
      params.require(:ingredient).permit(:food, :count, :units)
    end
end
