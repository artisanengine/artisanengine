class AddWeightToVariants < ActiveRecord::Migration
  def change
    add_column :variants, :weight, :decimal, precision: 8, scale: 2
  end
end
