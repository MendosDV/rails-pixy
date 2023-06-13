class AddSelectedToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :selected, :boolean, default: false
  end
end
