# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# $(document).on 'page:update', ->
$ ->
  $('.update-question-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    $('.question-cont').hide()
    $('.edit-question-form').removeClass('hidden')
    return

  $('.upvote-btn, .downvote-btn').bind "ajax:success", (e, data, status, xhr) ->
    if data.errors
      data.errors.map (value, key) ->
        $.jGrowl(value)
    else if(Number.isInteger(data.rang))
      selector = '.' + data.votable + '-rating-' + data.id
      $(selector).html(data.rang)
    return
  $('.upbote-btn, .downvote.btn').bind "ajax:error", (e, data, status, xht) ->
    $('body').remove()
    $.jGrowl("Возникла ошибка")
    return
