json.array! @notifications do |notification|
  json.actor notification.actor.username
  json.action notification.action
  json.notifiable do
    json.type notification.notifiable.notification_to_s
  end
  json.url polymorphic_path(notification.notifiable)
end

