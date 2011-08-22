class AddShortDescriptionToGoods < ActiveRecord::Migration
  def change
    add_column :goods, :short_description, :string
  end
end
