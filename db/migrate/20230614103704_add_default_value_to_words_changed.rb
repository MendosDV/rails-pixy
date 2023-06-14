class AddDefaultValueToWordsChanged < ActiveRecord::Migration[7.0]
  def change
    change_column :visits, :words_changed, :integer, default: 0
  end
end
