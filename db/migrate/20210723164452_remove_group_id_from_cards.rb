class RemoveGroupIdFromCards < ActiveRecord::Migration[6.1]
  def change
    remove_column :cards, :group_id
    drop_table :groups
  end
end
