class AddPromotionToAdjustments < ActiveRecord::Migration
  def change
    add_column :adjustments, :promotion, :boolean, default: false
  end
end
