class StarsController < ApplicationController
  include CurrentRecipe
  before_action :set_viewable_recipe, except: [:index]

  # POST /instructions
  def create
    @star = Star.find_or_create_by(recipe_id: @recipe.id, user_id: current_user.id)
    redirect_to @recipe, notice: 'Recipe starred!'
  end

  def destroy
    @star = current_user.stars.where(recipe_id: @recipe.id).first
    @star.destroy if @star
    redirect_to @recipe, notice: 'Star removed.'
  end

  def index
    case
    when params[:recipe_id]
      @recipe = Recipe.find(params[:recipe_id])
      render 'recipe_index'
    when params[:username]
      @user = User.where(username: params[:username]).first!
      render 'user_index'
    end
  rescue ActiveRecord::RecordNotFound
    logger.error "Attempt to view stars of a non-existant user or recipe"
    redirect_to current_user, alert: "Stars not found."
  end

end
