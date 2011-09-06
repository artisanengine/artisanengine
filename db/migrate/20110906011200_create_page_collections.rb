class CreatePageCollections < ActiveRecord::Migration
  def change
    create_table :page_collections do |t|
      t.integer :frame_id,      null: false
      t.string  :name,          null: false
      t.string  :cached_slug

      t.timestamps
    end
  end
end
