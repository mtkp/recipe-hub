class IngredientsController < ApplicationController
  include CurrentRecipe
  before_action :set_editable_recipe
  before_action :set_ingredient, except: [:new, :create]

  def new
    @ingredient = Ingredient.new
    respond_to do |format|
      format.html
      format.js { render template: 'shared/new_item', locals: { item: @ingredient } }
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js { render template: 'shared/edit_item', locals: { item: @ingredient } }
    end
  end

  def create
    @ingredient = @recipe.ingredients.build(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to @recipe, notice: 'Ingredient was successfully created.' }
        format.js { render template: 'shared/create_item', locals: { item: @ingredient, recipe: @recipe } }
        format.json { render action: 'show', status: :created, location: @ingredient }
      else
        format.html { render action: 'new' }
        format.js { render template: 'shared/new_item', locals: { item: @ingredient } }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to @recipe, notice: 'Ingredient was successfully updated.' }
        format.js { render template: 'shared/update_item', locals: { item: @ingredient } }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.js { render template: 'shared/edit_item', locals: { item: @ingredient } }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to @recipe }
      format.js { render template: 'shared/destroy_item', locals: { item: @ingredient } }
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
