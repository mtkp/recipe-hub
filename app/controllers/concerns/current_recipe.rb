module CurrentRecipe
  extend ActiveSupport::Concern

  private

    def set_recipe
      @recipe = current_user.recipes.find(params[:recipe_id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access non-existant or unauthorized recipe"
      redirect_to user_path(current_user), alert: "Recipe was not found."
    end

end