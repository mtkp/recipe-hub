class UsersController < ApplicationController
  
  def show
    @user = if params[:id].present?
              User.find(params[:id])
            else
              current_user
            end
    @recent_recipes = @user.recipes.order('updated_at desc').first(5)
  end

end
