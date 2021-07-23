class ChangeLevelTypeInGroups < ActiveRecord::Migration[6.1]
  def change
    change_column :groups, :level,:string
  end
end
