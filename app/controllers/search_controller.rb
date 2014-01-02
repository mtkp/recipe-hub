class SearchController < ApplicationController

  def show
    @found_items = Recipe.search(params[:search_terms]).paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end
end
