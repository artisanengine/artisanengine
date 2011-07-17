class CreateInitialArtisanEngineSchema < ActiveRecord::Migration
  def up
    
    # ------------------------------------------------------------------
    # Frames & Settings
    
    create_table :frames do |t|
      t.string :name,               null: false
      t.string :domain,             null: false
    end
    
    add_index :frames, :domain, unique: true
    
    create_table :settings do |t|
      t.integer :frame_id,          null: false
      
      t.string  :name,              null: false
      t.string  :value,             null: false
    end
    
    add_index :settings, [ :name, :frame_id ]
    
    # ------------------------------------------------------------------
    # Pages
    
    create_table :pages do |t|
      t.integer :frame_id,          null: false
      
      t.string  :title,             null: false
      t.text    :content
      t.text    :html_content

      t.string  :cached_slug        # Friendly ID

      t.timestamps
    end
    
    add_index :pages, [ :id, :frame_id ]
    
    # ------------------------------------------------------------------
    # Users
    
    create_table :engineers do |t|
      t.string  :email,             null: false
      
      # Devise
      t.database_authenticatable
    end
    
    create_table :artisans do |t|
      t.integer :frame_id,          null: false
      
      t.string  :first_name,        null: false
      t.string  :last_name,         null: false
      t.string  :email,             null: false
      
      # Devise
      t.database_authenticatable
    end
    
    add_index :artisans, :email, unique: true
    
    # ------------------------------------------------------------------
    # Images and ImageAttachers
    
    create_table :images do |t|
      t.integer :frame_id,          null: false
      
      t.string  :image_uid
      t.string  :image_name
      
      t.timestamps
    end
    
    add_index :images, [ :id, :frame_id ]
    
    create_table :image_attachers do |t|
      t.integer    :image_id,       null: false
      t.references :imageable,      null: false, polymorphic: true
      t.integer    :display_order,  null: false
    end
    
    # ------------------------------------------------------------------
    # Blogs & Posts
    
    create_table :blogs do |t|
      t.integer :frame_id,          null: false
      
      t.string  :name,              null: false
    end
    
    add_index :blogs, [ :id, :frame_id ]
    
    create_table :posts do |t|
      t.integer :blog_id,           null: false
      
      t.string  :title,             null: false
      t.text    :content
      t.text    :html_content
      
      t.timestamps
    end
    
    add_index :posts, [ :id, :blog_id ]
    
    # ------------------------------------------------------------------
    # Tags & Taggings
    
    create_table :tags do |t|
      t.integer :frame_id,          null: false
      t.string  :name,              null: false
      
      t.string  :cached_slug        # Friendly ID
      
      t.timestamps
    end
    
    add_index :tags, [ :id, :frame_id ]
    
    create_table :taggings do |t|
      t.integer    :tag_id,         null: false
      t.references :taggable,       null: false, polymorphic: true
    end
    
    # ------------------------------------------------------------------
    # Goods
    
    create_table :goods do |t|
      t.integer :frame_id,          null: false
      
      t.string  :name,              null: false
      t.text    :description
      t.text    :html_description
      
      t.string  :cached_slug        # Friendly ID
      
      t.timestamps
    end
    
    add_index :goods, [ :id, :frame_id ]
    
    # ------------------------------------------------------------------
    # Options
    
    create_table :options do |t|
      t.integer :good_id,           null: false
      
      t.integer :order_in_good,     null: false
      
      t.string  :name,              null: false
      t.string  :default_value,     null: false
    end
    
    add_index :options, [ :id, :good_id ]
    
    # ------------------------------------------------------------------
    # Variants
    
    create_table :variants do |t|
      t.integer :good_id,           null: false
      
      t.integer :display_order,     null: false
      
      t.integer :price_in_cents,    null: false, default: 0
      t.string  :currency
      
      t.string  :option_value_1
      t.string  :option_value_2
      t.string  :option_value_3
      t.string  :option_value_4
      t.string  :option_value_5
    end
    
    add_index :variants, [ :id, :good_id ]
    
    # ------------------------------------------------------------------
    # Orders & Line Items
    
    create_table :orders do |t|
      t.integer :frame_id,            null: false
      t.integer :id_in_frame
      t.integer :patron_id
      t.integer :shipping_address_id
      t.integer :billing_address_id
      t.string  :status,              null: false
      
      t.timestamps
    end
    
    create_table :line_items do |t|
      t.integer :order_id,          null: false
      t.integer :variant_id
      t.integer :quantity,          null: false, default: 1
      t.integer :price_in_cents,    null: false, default: 0
      t.string  :currency
      
      t.timestamps
    end
    
    # ------------------------------------------------------------------
    # Order Transactions
    
    create_table :order_transactions do |t|
      t.integer :order_id,          null: false
      t.integer :amount_in_cents,   null: false, default: 0
      t.string  :currency
      
      t.boolean :success,           null: false
      t.string  :reference
      t.string  :action
      t.text    :params
      t.boolean :test,              default: false
      t.string  :payment_service
      
      t.timestamps
    end
    
    # ------------------------------------------------------------------
    # Order Adjustments
    
    create_table :order_adjustments do |t|
      t.integer   :order_id,        null: false
      t.integer   :line_item_id
      t.integer   :amount_in_cents, null: false, default: 0
      t.string    :currency
      t.string    :message,         null: false
      
      t.timestamps
    end
    
    # ------------------------------------------------------------------
    # Order Fulfillments
    
    create_table :fulfillments do |t|
      t.integer   :order_id,        null: false
      t.integer   :cost_in_cents,   null: false, default: 0
      t.string    :currency
      t.string    :tracking
      t.string    :shipping_method
    
      t.timestamps
    end
    
    # ------------------------------------------------------------------
    # Addresses
    
    create_table :addresses do |t|
      t.integer   :frame_id,        null: false
      t.integer   :patron_id
      t.string    :first_name,      null: false
      t.string    :last_name,       null: false
      t.string    :address_1,       null: false
      t.string    :address_2
      t.string    :country,         null: false
      t.string    :city,            null: false
      t.string    :province
      t.string    :postal_code,     null: false
      
      t.timestamps
    end
    
    create_table :address_attachers do |t|
      t.integer    :address_id,     null: false
      t.references :addressable,    null: false, polymorphic: true
    end
    
    # ------------------------------------------------------------------
    # Patrons
    
    create_table :patrons do |t|
      t.integer   :frame_id,        null: false
      t.string    :first_name,      null: false
      t.string    :last_name,       null: false
      t.string    :email,           null: false
      t.boolean   :subscribed,      default: false

      t.timestamps
    end
    
    # ------------------------------------------------------------------
    # Display Cases & Collects
    
    create_table :display_cases do |t|
      t.integer   :frame_id,        null: false
      
      t.string    :name,            null: false
      
      t.string    :cached_slug      # Friendly ID
    end
    
    add_index :display_cases, [ :id, :frame_id ]
      
    create_table :collects do |t|
      t.integer   :display_case_id, null: false
      t.integer   :good_id,         null: false
      
      t.integer   :display_order,   null: false
    end
    
    # ------------------------------------------------------------------
    # Friendly ID
    
    create_table :slugs do |t|
      t.string    :name
      t.integer   :sluggable_id
      t.integer   :sequence,        null: false, default: 1
      t.string    :sluggable_type,               limit: 40
      t.string    :scope
      t.datetime  :created_at
    end
    
    add_index :slugs, :sluggable_id
    add_index :slugs, [ :name, :sluggable_type, :sequence, :scope ], name: "index_slugs_on_n_s_s_and_s", unique: true
    
  end

  def down
    raise ActiveRecord::IrreversibleMigration       # No going back.
  end
end
