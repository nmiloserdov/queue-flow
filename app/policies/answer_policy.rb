class AnswerPolicy < ApplicationPolicy
   include RangPolicy

   def best?
     if user && record.question
       (user.id == record.question.user_id || user.admin?)
     else
       false
     end
   end
end

