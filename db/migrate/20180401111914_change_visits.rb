class ChangeVisits < ActiveRecord::Migration[5.1]
	#Changing db type using migrations From: https://stackoverflow.com/questions/2799774/rails-migration-for-change-column
  def change
  	change_column(:appointments, :visited, :string)
  end
end
