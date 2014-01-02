class SearchController < ApplicationController

  def show
    @found_items = Recipe.search(params[:search_terms])
    respond_to do |format|
      format.html
      format.js
    end
  end
end
