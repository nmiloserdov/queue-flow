
ready= ->
  $('.update-question-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    $('.question-cont').hide()
    $('.edit-question-form').removeClass('hidden')
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

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
