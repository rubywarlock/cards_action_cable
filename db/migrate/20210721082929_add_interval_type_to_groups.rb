class AddIntervalTypeToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :interval_type, :string
  end
end
