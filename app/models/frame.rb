class Frame < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  has_many :pages
  has_many :users
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of   :name, :domain
  validates_uniqueness_of :domain
end
