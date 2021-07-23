class RenameTransalteToTranslateInWordsPairs < ActiveRecord::Migration[6.1]
  def change
    rename_column :words_pairs, :transalte, :translate
  end
end
