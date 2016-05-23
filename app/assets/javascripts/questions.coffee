# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'page:update', ->
  $('.update-question-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    $('.question').hide()
    $('.edit-question-form').removeClass('hidden')
    return

  # $('.upvote-btn').click (e) ->
  #   e.preventDefault()
  #   link = $(this).attr('href')
  #   $.ajax(
  #     url: link,
  #     accepts: 'AJAX',
  #     method: 'patch').done ->
  #       $(this).addClass 'done'
  #     return
  #   return

  # $('.downvote-btn').click (e) ->
  #   return

  # $('.upvote-btn').bind 'ajax:success', (e,data,status,xhr) ->
  #   console.log("hi")
  #   rating = $.parseJSON(xhr.respondText)
  #   alert(rating)

