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
     <div class="edit-textarea-cont"><fieldset class="inputs"><ol>
     <label for="answer_body">Body</label><textarea name="answer[body]" id="answer_body">
     </textarea></ol></fieldset>
    <div class="attachments-cont col-md-2">
    <label>Attachnemts</label>
    <div class="attachments"></div>
    <a data-association-insertion-method="append" data-association-insertion-node=".attachments" class="add_fields" data-association="attachment" data-associations="attachments" data-association-insertion-template="&lt;div class=&quot;nested-fields&quot;&gt;
    &lt;div class=&quot;attachment-fileds&quot;&gt;
    &lt;label for=&quot;answer_attachments_attributes_new_attachments_file&quot;&gt;File&lt;/label&gt;&lt;input type=&quot;file&quot; name=&quot;answer[attachments_attributes][new_attachments][file]&quot; id=&quot;answer_attachments_attributes_new_attachments_file&quot; /&gt;
    &lt;/div&gt;
    &lt;input type=&quot;hidden&quot; name=&quot;answer[attachments_attributes][new_attachments][_destroy]&quot; id=&quot;answer_attachments_attributes_new_attachments__destroy&quot; value=&quot;false&quot; /&gt;&lt;a class=&quot;remove_fields dynamic&quot; href=&quot;#&quot;&gt;remove&lt;/a&gt;
    &lt;/div&gt;" href="#">add file</a><br /><input type="submit" name="commit" value="Add" />
    </div>
    </form>')
    return

  $('.update-answer-link').click (e) ->
   e.preventDefault()
   $(this).hide()
   $('.update-answer-link').hide()
   answer_id         = $(this).data('answerId')
   answer_body       = $(this).data('answerBody')
   attachments_ids   = $(this).data('attachmentIds')
   attachemnts_names = $(this).data('attachmentNames')
   links_html = ""

   if attachments_ids.length > 0
     for i in [0..attachments_ids.length - 1]
       html =  '<div class="attach-'+ attachments_ids[i] + '"<p class="attachment_name">'+ attachemnts_names[i].file.url.replace(/^.*[\\\/]/, '') + '</p>'
       html += '<a class="delete-attach-link" data-attachment-id="'+ attachments_ids[i] + '" data-remote="true" rel="nofollow" data-method="delete" href="/attachments/'+ attachments_ids[i] + '">remove</a></div><br/>'
       links_html += html
   $('.answer-' + answer_id).html('
     <div class="answer_errors"></div>
     <form id="edit-answer-71" action="/answers/' + answer_id + '" accept-charset="UTF-8" data-remote="true" method="post">
     <input name="utf8" type="hidden" value="&#x2713;" />
     <input type="hidden" name="_method" value="patch" />
        <label for="answer_body">Body</label>
        <textarea name="answer[body]" id="answer_body">' + answer_body + '</textarea>
        <label>Attachnemts</label>'+ links_html + '<div class="attachments"></div>
        <a data-association-insertion-method="append" data-association-insertion-node=".attachments" class="add_fields" data-association="attachment" data-associations="attachments" data-association-insertion-template="&lt;div class=&quot;nested-fields&quot;&gt;
        &lt;div class=&quot;attachment-fileds&quot;&gt;
        &lt;label for=&quot;answer_attachments_attributes_new_attachments_file&quot;&gt;File&lt;/label&gt;&lt;input type=&quot;file&quot; name=&quot;answer[attachments_attributes][new_attachments][file]&quot; id=&quot;answer_attachments_attributes_new_attachments_file&quot; /&gt;
        &lt;/div&gt; &lt;input type=&quot;hidden&quot; name=&quot;answer[attachments_attributes][new_attachments][_destroy]&quot; id=&quot;answer_attachments_attributes_new_attachments__destroy&quot; value=&quot;false&quot; /&gt;&lt;a class=&quot;remove_fields dynamic&quot; href=&quot;#&quot;&gt;remove&lt;/a&gt;
        &lt;/div&gt;" href="#">add file</a><br /><input type="submit" name="commit" value="update" /></form>
      </div>')
   return
  $('.delete-attach-link').click (e) ->
    attach_id = $(this).data('attachmentId')
    console.log(attach_id)
    $('.attach-' + attach_id).hide()
    return

  $('.delete-answer-link').click (e) ->
   e.preventDefault()
   answer_id = $(this).data('answerId')
   $('.answer-'+ answer_id).hide()
   return
