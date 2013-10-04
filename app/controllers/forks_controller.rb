class ForksController < ApplicationController
  include CurrentRecipe
  before_action :set_viewable_recipe

  def index
  end

  def create
    @new_recipe = Recipe.duplicate! @recipe, user_id: current_user.id
    @new_recipe.source_recipe = @recipe

    if @new_recipe.save
      redirect_to @new_recipe, notice: "#{@recipe.title} forked!"
    else
      redirect_to @recipe, notice: "Unable to fork recipe"
    end
  end

end
