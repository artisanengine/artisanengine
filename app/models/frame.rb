class Frame < ActiveRecord::Base
  attr_accessible :name, :domain
  
  # ------------------------------------------------------------------
  # Callbacks
  
  after_create          :initialize_blog
  after_create          :initialize_featured_display_case
  
  # ------------------------------------------------------------------
  # Associations
  
  has_many :settings
  has_many :artisans
  has_many :patrons
  has_many :pages
  has_many :users
  has_many :images
  has_many :tags
  has_many :goods
  has_one  :blog
  has_many :display_cases
  has_many :orders
  has_one  :featured_case, class_name: 'DisplayCase', conditions: [ 'display_cases.name = ?', 'Featured' ]
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of   :name, :domain
  validates_uniqueness_of :domain
  
  # ------------------------------------------------------------------
  private
  
  def initialize_blog
    create_blog name: "#{ name } Blog"
  end
  
  def initialize_featured_display_case
    display_cases.create! name: "Featured"
  end
end
