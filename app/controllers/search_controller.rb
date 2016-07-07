class SearchController < ApplicationController
  include SearchHelper

  def search
    authorize :search
    @result = sphinx_search(params[:query], params[:scope], params[:page])
  end
end
