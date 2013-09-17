class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :destroy]

  def index
    @user = User.where(username: params[:username]).first!
    @recipes = @user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    @author = User.find(@recipe.user_id)
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render action: 'show', status: :created, location: @recipe }
      else
        format.html { render action: 'new' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to user_recipes_url(@recipe.user) }
      format.json { head :no_content }
    end
  end

  def fork
    source_recipe = Recipe.find(params[:id])
    @recipe = source_recipe.fork_for current_user
    if @recipe
      redirect_to @recipe, notice: "#{source_recipe.title} forked!"
    else
      redirect_to source_recipe
    end
  end

  private

    def set_recipe
      @recipe = current_user.recipes.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access non-existant or unauthorized recipe"
      redirect_to current_user, alert: "Recipe was not found."
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:title, :notes)
    end

end
