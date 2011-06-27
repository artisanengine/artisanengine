class Frame < ActiveRecord::Base
  attr_accessible :name, :domain
  
  # ------------------------------------------------------------------
  # Associations
  
  has_many :pages
  has_many :users
  has_many :images
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of   :name, :domain
  validates_uniqueness_of :domain
end
