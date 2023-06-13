class AddColumnToVisits < ActiveRecord::Migration[7.0]
  def change
    add_column :visits, :title, :string
  end
end
