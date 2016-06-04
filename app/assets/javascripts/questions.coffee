ready= ->
  $('.update-question-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    $('.question-cont').hide()
    $('.edit-question-form').removeClass('hidden')
    return

  $('.add-comment-btn').click (e) ->
    e.preventDefault()
    $(this).hide()
    form_id = $(this).data('formId')
    type    = $(this).data('type')
    $('.comment-' + type + '-form-' + form_id).removeClass("hidden")
    $('.add-comment-btn').hide()
    return

  $('.upvote-btn, .downvote-btn')
    .bind "ajax:success", (e, data, status, xhr) ->
      if(Number.isInteger(data.rang))
        selector = '.' + data.votable + '-rating-' + data.id
        $(selector).html(data.rang)
      return
    .on "ajax:error", (e, data, status, xht) ->
      data = (data.responseJSON)
      data.errors.map (value, key) ->
        $.jGrowl(value)

  PrivatePub.subscribe '/questions', (data, chanel) ->
    question = $.parseJSON(data['question'])
    # как рендерить темплейт?
    $('.questions-container').prepend('<p>'+question.body+'<p>')
    $('.questions-container').prepend('<p>'+question.title+'<p>')

  PrivatePub.subscribe '/comments', (data, chanel) ->
    console.log(data)
    # question = $.parseJSON(data['question'])
    # # как рендерить темплейт?
    # $('.questions-container').prepend('<p>'+question.body+'<p>')
    # $('.questions-container').prepend('<p>'+question.title+'<p>')

$(document).on('page:update', ready)
