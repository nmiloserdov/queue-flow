# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'page:update', ->
  $('.update-question-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    $('.edit-question-form').removeClass('hidden')
    return
