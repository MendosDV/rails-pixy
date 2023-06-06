class FixColumnNameAtProfiles < ActiveRecord::Migration[7.0]
  def change
    rename_column :profiles, :nickame, :nickname
  end
end
