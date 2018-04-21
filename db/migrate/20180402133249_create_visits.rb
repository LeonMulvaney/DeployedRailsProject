class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.string :date
      t.string :infection_injury
      t.string :visit_description
      t.string :special_observations
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
