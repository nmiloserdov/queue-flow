module SearchHelper 
  SCOPES= %w(global question answer comment user)

  def search_form_tag
    select_tag :scope, options_for_select(SCOPES), class: 'form-control'
  end

  def print_search_result_for(resource)
    case resource
    when User
      "User: #{resource.email}"
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
end
