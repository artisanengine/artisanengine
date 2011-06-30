class CreateInitialArtisanEngineSchema < ActiveRecord::Migration
  def up
    
    # ------------------------------------------------------------------
    # Frames
    
    create_table :frames do |t|
      t.string :name,   null: false
      t.string :domain, null: false
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
    
    add_index :pages, [ :id, :frame_id ]
    
    # ------------------------------------------------------------------
    # Users
    
    create_table :engineers do |t|
      t.string  :email
      t.database_authenticatable
    end
    
    create_table :artisans do |t|
      t.integer :frame_id
      
      t.string  :first_name
      t.string  :last_name
      t.string  :email
      
      # Devise
      t.database_authenticatable
    end
    
    add_index :artisans, :email, unique: true
    
    # ------------------------------------------------------------------
    # Images
    
    create_table :images do |t|
      t.integer :frame_id
      
      t.string  :image_uid
      t.string  :image_name
      
      t.timestamps
    end
    
    add_index :images, [ :id, :frame_id ]
    
  end

  def down
    raise ActiveRecord::IrreversibleMigration       # No going back.
  end
end
