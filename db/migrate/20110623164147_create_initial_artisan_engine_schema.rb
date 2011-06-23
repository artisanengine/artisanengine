class CreateInitialArtisanEngineSchema < ActiveRecord::Migration
  def up
    create_table :frames do |t|
      t.string :name,   null: false
      t.string :domain, null: false

      t.timestamps
    end
    
    #create_table :pages do |t|
    #  t.integer :frame_id,  null: false
      
    #  t.string  :title,     null: false
    #  t.text    :content,   null: false

    #  t.timestamps
    #end
  end

  def down
    raise ActiveRecord::IrreversibleMigration       # No going back.
  end
end
