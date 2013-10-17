class SearchController < ApplicationController

  def show
    @found_items = Recipe.search(params[:search_terms])
  end
end
