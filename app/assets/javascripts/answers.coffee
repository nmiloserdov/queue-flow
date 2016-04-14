# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:update', ->

  $('.add-answer-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    question_id = $(this).data('questionId')
    $('.add-answer').html('
    <form class="new_answer" id="new_answer" action="/questions/'+ question_id + '/answers" accept-charset="UTF-8" data-remote="true" method="post"><input name="utf8" type="hidden" value="&#x2713;" />
      <div class="answer_errors"></div>
      <label for="answer_body">Body</label><br />
      <textarea name="answer[body]" id="answer_body"></textarea><br />
      <input type="submit" name="commit" value="Add" class="btn btn-primary" />
    </form>')
    return
  $('.update-answer-link').click (e) ->
   e.preventDefault()
   $(this).hide()
   $('.update-answer-link').hide()
   answer_id = $(this).data('answerId')
   answer_body = $(this).data('answerBody')
   $('.edit-form-cont-' + answer_id).html('
     <div class="answer_errors"></div>
     <form id="edit-answer-71" action="/answers/' + answer_id + '" accept-charset="UTF-8" data-remote="true" method="post">
     <input name="utf8" type="hidden" value="&#x2713;" />
     <input type="hidden" name="_method" value="patch" />
        <label for="answer_body">Body</label>
        <textarea name="answer[body]" id="answer_body">
        ' + answer_body + '
        </textarea>
        <input type="submit" name="commit" value="update" /></form>
      </div>')
  $('.delete-answer-link').click (e) ->
   e.preventDefault()
   answer_id = $(this).data('answerId')
   $('.answer-'+ answer_id).hide()
   return
