json.extract! event, :id, :title, :scheduled_at, :created_at, :updated_at
json.url event_url(event, format: :json)
