class CreateWordsPairs < ActiveRecord::Migration[6.1]
  def change
    create_table :words_pairs do |t|
      t.string :original_text
      t.string :transalte
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
