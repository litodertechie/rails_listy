module CommentsHelper
  def reply_to_comment_id(comment, nesting, max_nesting)
    #use the comment as the parent if we allow unlimited nesting or if we're within the allowed nesting
    if max_nesting.blank? || nesting < max_nesting
     comment.id
    else
      #otherwise we use the comment's parent, and nest the new comment as a sibling
      comment.parent_id
    end
  end
end
