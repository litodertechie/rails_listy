class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: "Comment"
  after_create :track_comment_create

  def comments
    Comment.where(commentable: commentable, parent_id: id)
  end

  def track_comment_create
    $tracker.track( user_id, 'Commented List')
  end
end
