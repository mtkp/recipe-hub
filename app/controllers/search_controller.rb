class SearchController < ApplicationController

  def show
    params[:search_terms].strip!
    @found_items = Recipe.search(params[:search_terms])
    respond_to do |format|
      format.html
      format.js
    end
  end
end
