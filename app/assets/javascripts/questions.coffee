# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.update-question-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    question_body = $(this).data('questionBody')
    question_title = $(this).data('questionTitle')
    $('.edit-question-form').html('
       <form class="edit_question" id="edit_question_1" action="/questions/1" accept-charset="UTF-8" data-remote="true" method="post">
         <input name="utf8" type="hidden" value="&#x2713;" />
         <input type="hidden" name="_method" value="patch" />
         <label for="question_title">Title</label>
         <input type="text" value="'+ question_title + '" name="question[title]" id="question_title" />
         <label for="question_Body">Body</label>
         <textarea name="question[body]" id="question_body">' + question_body + '</textarea>
         <input type="submit" name="commit" value="update" />
       </form>
      ')
    return
