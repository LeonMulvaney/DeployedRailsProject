json.extract! patient, :id, :name, :dob, :address, :phone, :created_at, :updated_at
json.url patient_url(patient, format: :json)
