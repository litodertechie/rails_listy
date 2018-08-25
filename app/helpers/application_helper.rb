module ApplicationHelper
  def liked_list(list)
    liked = current_user.liked?(list) ? 'liked' : ''
    content_tag(:i, '', class: "fa fa-heart #{liked}")
  end

end
