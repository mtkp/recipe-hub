class StarsController < ApplicationController
  before_action :set_recipe, except: [:index]

  # POST /instructions
  def create
    @star = Star.find_or_create_by(recipe_id: @recipe.id, user_id: current_user.id)
    redirect_to @recipe, notice: 'Recipe starred!'
  end

  def destroy
    @star = current_user.stars.find_by(recipe_id: @recipe.id)
    @star.destroy if @star
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

  private
    def set_recipe
      @recipe = Recipe.find(params[:recipe_id])
    end

end
