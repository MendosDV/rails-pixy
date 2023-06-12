class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :current_category_id, :string
  end
end
