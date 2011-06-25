class CreateInitialArtisanEngineSchema < ActiveRecord::Migration
  def up
    
    # ------------------------------------------------------------------
    # Frames
    
    create_table :frames do |t|
      t.string :name,   null: false
      t.string :domain, null: false

      t.timestamps
    end
    
    add_index :frames, :domain, unique: true
    
    # ------------------------------------------------------------------
    # Pages
    
    create_table :pages do |t|
      t.integer :frame_id,  null: false
      
      t.string  :title,     null: false
      t.text    :content,   null: false

      t.timestamps
    end
    
    add_index :pages, :frame_id
    
    # ------------------------------------------------------------------
    # Users
    
    create_table :users do |t|
      t.integer :frame_id
      
      t.string  :first_name
      t.string  :last_name
      t.string  :email
      t.string  :role
      
      # Devise
      t.database_authenticatable
      
      t.timestamps
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration       # No going back.
  end
end
