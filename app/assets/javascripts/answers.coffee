# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:update', ->

  $('.add-answer-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    form = $('.add-answer-form').removeClass('hidden')
    $('.add-answer').html(form)
    return

  $('.update-answer-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    $('.update-answer-link').hide()
    answer_id = $(this).data('answerId')
    form = $(".edit-answer-#{answer_id}-form").removeClass('hidden')
    $(".answer-#{answer_id}").html(form)
    return

  $('.delete-answer-link').click (e) ->
    e.preventDefault()
    answer_id = $(this).data('answerId')
    $('.answer-'+ answer_id).hide()
    return

  $('.delete-attachment-link').click (e) ->
    e.preventDefault()
    attach_id = $(this).data('attachmentId')
    $(".attachment-#{attach_id}").hide()
    return


