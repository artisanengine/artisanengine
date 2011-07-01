class CreateInitialArtisanEngineSchema < ActiveRecord::Migration
  def up
    
    # ------------------------------------------------------------------
    # Frames
    
    create_table :frames do |t|
      t.string :name,         null: false
      t.string :domain,       null: false
    end
    
    add_index :frames, :domain, unique: true
    
    # ------------------------------------------------------------------
    # Pages
    
    create_table :pages do |t|
      t.integer :frame_id,    null: false
      
      t.string  :title,       null: false
      t.text    :content,     null: false
      t.text    :html_content

      t.timestamps
    end
    
    add_index :pages, [ :id, :frame_id ]
    
    # ------------------------------------------------------------------
    # Users
    
    create_table :engineers do |t|
      t.string  :email,       null: false
      
      # Devise
      t.database_authenticatable
    end
    
    create_table :artisans do |t|
      t.integer :frame_id,    null: false
      
      t.string  :first_name,  null: false
      t.string  :last_name,   null: false
      t.string  :email,       null: false
      
      # Devise
      t.database_authenticatable
    end
    
    add_index :artisans, :email, unique: true
    
    # ------------------------------------------------------------------
    # Images
    
    create_table :images do |t|
      t.integer :frame_id,    null: false
      
      t.string  :image_uid
      t.string  :image_name
      
      t.timestamps
    end
    
    add_index :images, [ :id, :frame_id ]
    
    # ------------------------------------------------------------------
    # Blogs & Posts
    
    create_table :blogs do |t|
      t.integer :frame_id,    null: false
      
      t.string  :name
    end
    
    add_index :blogs, [ :id, :frame_id ]
    
    create_table :posts do |t|
      t.integer :blog_id,     null: false
      
      t.string  :title,       null: false
      t.text    :content,     null: false
      t.text    :html_content
      
      t.timestamps
    end
    
    add_index :posts, [ :id, :blog_id ]
    
    # ------------------------------------------------------------------
    # Tags & Taggings
    
    create_table :tags do |t|
      t.integer :frame_id,  null: false
      t.string  :name,      null: false
      
      t.timestamps
    end
    
    add_index :tags, [ :id, :frame_id ]
    
    create_table :taggings do |t|
      t.integer    :tag_id,   null: false
      t.references :taggable, polymorphic: true
    end
    
    # ------------------------------------------------------------------
    # Goods
    
    create_table :goods do |t|
      t.integer :frame_id,         null: false
      
      t.string  :name,             null: false
      t.text    :description
      t.text    :html_description
      
      t.timestamps
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration       # No going back.
  end
end
