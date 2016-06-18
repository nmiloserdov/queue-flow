module RangPolicy

  def upvote?
    user && (user.id != record.user_id || user.admin?)
  end

  def downvote?
    user && (user.id != record.user_id || user.admin?)
  end
end
