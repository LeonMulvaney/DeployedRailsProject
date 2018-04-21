class CreatePrescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :prescriptions do |t|
      t.string :date
      t.string :patient_name
      t.string :medication_name
      t.string :strength
      t.string :frequency
      t.integer :duration
      t.string :special_instructions
      t.string :follow_up

      t.timestamps
    end
  end
end
