class AddCompletedAtToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :completed_at, :datetime
  end
end
