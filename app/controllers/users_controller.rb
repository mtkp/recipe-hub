class UsersController < ApplicationController
  before_action :set_user
  
  def show
    @recent_recipes = @user.recipes.order('updated_at desc').first(10)
  end

  private
    def set_user
      @user = if params[:username].present?
                User.where(username: params[:username]).first!
              else
                current_user
              end
    rescue ActiveRecord::RecordNotFound
      redirect_to current_user, notice: "User not found"
    end
end
