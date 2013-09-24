class CollectionsController < ApplicationController
  
  def index
    @user = User.where(username: params[:username]).first!
    @collections = @user.collections
  rescue ActiveRecord::RecordNotFound
    logger.error "Attempt to view stars of a non-existant user or recipe"
    redirect_to current_user, alert: "Stars not found."
  end

  def show
  end

end
