class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    redirect_to current_user if current_user
  end

end
