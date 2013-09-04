class StarsController < ApplicationController

  # POST /instructions
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @star = current_user.stars.build(recipe_id: @recipe.id)
    if @star.save
      redirect_to @recipe, notice: 'Recipe starred!'
    else
      redirect_to @recipe, notice: 'There was an error when starring this recipe...'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @star = current_user.stars.find_by(recipe_id: @recipe.id)
    @star.destroy
    redirect_to @recipe, notice: 'Star removed.'
  end

  def index
    case
    when params[:recipe_id]
      @recipe = Recipe.find(params[:recipe_id])
      render 'recipe_index'
    when params[:user_id]
      @user = User.find(params[:user_id])
      render 'user_index'
    end
  end

end
