class RenameTimeSpentToNextTimeInCards < ActiveRecord::Migration[6.1]
  def change
    rename_column :cards, :time_spent, :next_time
  end
end
