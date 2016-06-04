$ ->
  question_id = $('.update-question-link').data('questionId')
  PrivatePub.subscribe '/comments/' + question_id, (data, chanel) ->
    comment = $.parseJSON(data['comment'])
    id = comment.commentable_id
    commentable = comment.commentable_type.toLowerCase()
    switch (data.method)
      when "create"
        $('.comments-' + commentable + '-' + id)
          .prepend('<p>'+comment.body+'<p>')
        console.log('comment-'+ commentable + '-form-'+id)
        $('.comment-'+ commentable + '-form-'+id).addClass('hidden')
        $('.add-comment-btn').show()
      when "destroy"
        console.log(comment.id)
        $('.comment-' + comment.id).remove()
