module CurrentRecipe
  extend ActiveSupport::Concern

  private

    def set_editable_recipe
      @recipe = current_user.recipes.find(params[:recipe_id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access non-existant or unauthorized recipe"
      redirect_to current_user, alert: "Recipe was not found."
    end

    def set_viewable_recipe
      @recipe = Recipe.find(params[:recipe_id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access non-existant recipe"
      redirect_to current_user, alert: "Recipe was not found."
    end

end