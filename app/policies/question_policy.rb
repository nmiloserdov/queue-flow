class QuestionPolicy < ApplicationPolicy
   include RangPolicy

   def subscribe?
     user && !user.subscribed_to?(record)
   end

   def unsubscribe?
     user && user.subscribed_to?(record)
   end
end
