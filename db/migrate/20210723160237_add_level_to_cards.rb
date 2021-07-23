class AddLevelToCards < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :level, :string
  end
end
