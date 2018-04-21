class CreatePatients < ActiveRecord::Migration[5.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :dob
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
