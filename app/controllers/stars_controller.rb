class StarsController < ApplicationController
  include CurrentRecipe
  before_action :set_recipe

  # POST /instructions
  def create
    @instruction = @recipe.stars.build(user_id: current_user.id)

    if @instruction.save
      redirect_to @recipe, notice: 'Recipe starred!'
    else
      redirect_to @recipe, notice: 'There was an error when starring this recipe...'
    end
  end

  def destroy
    @star = current_user.stars.find_by(recipe_id: @recipe.id)
    @star.destroy
    redirect_to @recipe, notice: 'Star removed.'
  end

  def index
    @stars = @recipe.stars
  end
end
