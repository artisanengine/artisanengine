class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.integer :frame_id
      
      t.string :promotional_code
      t.decimal :discount_amount
      t.string :discount_type
      t.string :discount_target

      t.timestamps
    end
  end
end
