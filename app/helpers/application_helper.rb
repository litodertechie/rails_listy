module ApplicationHelper
  def liked_list(list)
    if current_user.username == "guestuser"
      liked = ''
    else
      liked = current_user.liked?(list) ? 'liked' : ''
    end
    content_tag(:i, '', class: "fa fa-heart #{liked}")
  end
end
