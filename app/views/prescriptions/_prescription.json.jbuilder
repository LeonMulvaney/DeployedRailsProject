json.extract! prescription, :id, :date, :patient_name, :medication_name, :strength, :frequency, :duration, :special_instructions, :follow_up, :created_at, :updated_at
json.url prescription_url(prescription, format: :json)
