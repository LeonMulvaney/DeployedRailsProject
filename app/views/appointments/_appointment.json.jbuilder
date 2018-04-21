json.extract! appointment, :id, :date, :time, :patient, :visited, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
