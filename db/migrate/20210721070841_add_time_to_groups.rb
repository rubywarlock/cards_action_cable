class AddTimeToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :time, :datetime
  end
end
