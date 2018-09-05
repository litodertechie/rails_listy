json.array! @notifications do |notification|
  json.actor notification.actor.username
  json.action notification.action
  json.notifiable do
    json.type "your list"
  end
  json.url list_path(notification.notifiable, anchor: dom_id(notification.notifiable))
end
