class SearchController < ApplicationController

  def search
    authorize :search
    @result = class_name.search(query, page: params[:page])
  end

  private

  def query
    ThinkingSphinx::Query.escape(params[:query])
  end
  
  def class_name
    if params[:scope].present?
      params[:scope].camelize.constantize
    else
      ThinkingSphinx
    end
  end
end
