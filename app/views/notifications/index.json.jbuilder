json.array! @notifications do |notification|
  # json.recipient notification.recipient
  json.actor notification.actor.username
  json.action notification.action
  json.notifiable do #notification.notifiable
    json.type "your list"
  end
  json.url list_path(notification.notifiable, anchor: dom_id(notification.notifiable))
end
