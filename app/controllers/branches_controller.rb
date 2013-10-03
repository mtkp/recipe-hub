class BranchesController < ApplicationController
  include CurrentRecipe
  before_action :set_editable_recipe
  before_action :set_collection
  
  def create
    @new_recipe = Recipe.duplicate!(@recipe)
    @new_recipe.collection = @collection
    @branch = Branch.new(recipe_id: @new_recipe.id, collection_id: @collection.id)

    if @branch.append_to_list
      redirect_to @new_recipe, notice: "Added #{@recipe.title} to the #{@collection.name} collection!"
    else
      redirect_to @recipe, notice: "Unable to fork recipe"
    end
  end

  def update
  end

  def destroy
  end

  private
    def set_collection
      @collection = Collection.find_or_create_for_recipe(@recipe)
    end
end
