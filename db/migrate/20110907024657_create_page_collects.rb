class CreatePageCollects < ActiveRecord::Migration
  def change
    create_table :page_collects do |t|
      t.integer :page_id
      t.integer :page_collection_id
      t.integer :display_order

      t.timestamps
    end
  end
end
