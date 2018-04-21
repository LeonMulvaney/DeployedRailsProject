class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.string :date
      t.string :time
      t.string :patient
      t.boolean :visited

      t.timestamps
    end
  end
end
