class CreateHospitalReferrals < ActiveRecord::Migration[5.1]
  def change
    create_table :hospital_referrals do |t|
      t.string :date
      t.string :patient_name
      t.string :hospital_name
      t.string :referral_reason
      t.string :department

      t.timestamps
    end
  end
end
