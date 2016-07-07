module SearchHelper 

  SCOPES= %w(global question answer comment user)

  def sphinx_search(query, scope=nil, page=nil)
    query = build_query(query)
    return nil if query.empty?
    class_name(scope).search(query, page: page)
  end

  def search_form_tag
    select_tag :scope, options_for_select(SCOPES), class: 'form-control'
  end

  def print_search_result_for(resource)
    case resource
    when Question
      link_to "Question: '#{resource.title}'", question_path(resource)
    when Answer
      link_to "Answer for: '#{resource.question.title}'", question_path(resource.question.id)
    when Comment
      if resource.commentable_type == "Question"
        link_to "Comment for '#{resource.commentable.title}'", question_path(resource.commentable.id)
      else
        link_to "Comment for answer '#{resource.commentable.question.title}'",
          question_path(resource.commentable.question.id)
      end
    end
  end

  private

  def build_query(query)
    ThinkingSphinx::Query.escape(params[:query])
  end

  def class_name(scope)
    return ThinkingSphinx if scope.nil? || scope == "global"

    if SCOPES.include?(scope.downcase)
      scope.camelize.constantize
    end
  end
end
