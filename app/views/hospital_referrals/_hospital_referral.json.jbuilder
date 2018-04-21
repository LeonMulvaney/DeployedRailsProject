json.extract! hospital_referral, :id, :date, :patient_name, :hospital_name, :referral_reason, :department, :created_at, :updated_at
json.url hospital_referral_url(hospital_referral, format: :json)
