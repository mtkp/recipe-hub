class ForksController < ApplicationController
  include CurrentRecipe
  before_action :set_viewable_recipe

  def index
  end
end
