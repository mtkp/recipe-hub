class StarsController < ApplicationController
  include CurrentRecipe
  before_action :set_viewable_recipe, except: [:index]

  # POST /instructions
  def create
    @star = Star.find_or_create_by(recipe_id: @recipe.id, user_id: current_user.id)
    respond_to do |format|
      format.html { redirect_to @recipe, notice: 'Recipe starred!' }
      format.js { render 'reload_partial' }
    end
  end

  def destroy
    @star = current_user.stars.where(recipe_id: @recipe.id).first
    @star.destroy if @star
    respond_to do |format|
      format.html { redirect_to @recipe, notice: 'Star removed.' }
      format.js { render 'reload_partial' }
    end
  end

  def index
    case
    when params[:recipe_id]
      @recipe = Recipe.find(params[:recipe_id])
    when params[:username]
      @user = User.where(username: params[:username]).first!
    end
  rescue ActiveRecord::RecordNotFound
    logger.error "Attempt to view stars of a non-existant user or recipe"
    redirect_to current_user, alert: "Stars not found."
  end

end
