class TagsController < ApplicationController

  before_action :set_tag

  def show
  end

  private
    def set_tag
      @tag = Tag.where(name: params[:name]).first!
    rescue ActiveRecord::RecordNotFound
      redirect_to current_user, notice: "Tag #{params[:name]} not found"
    end
end
