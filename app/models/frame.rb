class Frame < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  has_many :pages
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of   :name, :domain
  validates_uniqueness_of :domain
end
