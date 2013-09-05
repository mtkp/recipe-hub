class UsersController < ApplicationController
  
  def show
    @user = if params[:id].nil?
              current_user
            else
              User.find(params[:id])
            end
  end

end
