class AddConditionToPatients < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :allergy_condition, :string
  end
end
