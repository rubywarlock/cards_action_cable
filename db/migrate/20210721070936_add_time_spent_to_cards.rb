class AddTimeSpentToCards < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :time_spent, :datetime
  end
end
