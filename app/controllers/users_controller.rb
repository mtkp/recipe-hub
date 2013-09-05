class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = if params[:id].nil?
              current_user
            else
              User.find(params[:id])
            end
  end

end
