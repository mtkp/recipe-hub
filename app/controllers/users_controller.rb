class UsersController < ApplicationController
  
  def show
    @user = if params[:username].present?
              User.where(username: params[:username]).first!
            else
              current_user
            end
    @recent_recipes = @user.recipes.order('updated_at desc').first(10)
  rescue ActiveRecord::RecordNotFound
    redirect_to current_user, notice: "User not found"
  end 

end
