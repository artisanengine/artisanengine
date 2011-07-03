class Frame < ActiveRecord::Base
  attr_accessible :name, :domain
  
  # ------------------------------------------------------------------
  # Callbacks
  
  before_create           :initialize_blog
  
  # ------------------------------------------------------------------
  # Associations
  
  has_many :pages
  has_many :users
  has_many :images
  has_many :tags
  has_many :goods
  has_one  :blog
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of   :name, :domain
  validates_uniqueness_of :domain
  
  # ------------------------------------------------------------------
  private
  
  def initialize_blog
    create_blog name: "#{ name } Blog"
  end
end
