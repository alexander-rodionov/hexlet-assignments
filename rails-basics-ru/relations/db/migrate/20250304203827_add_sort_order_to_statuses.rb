class AddSortOrderToStatuses < ActiveRecord::Migration[7.2]
  def change
    add_column :statuses, :sort_order, :integer
  end
end
