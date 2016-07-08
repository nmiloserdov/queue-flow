class SearchController < ApplicationController

  def search
    authorize :search
    @result = Search.sphinx_search(params[:query], params[:scope], params[:page])
  end
end
