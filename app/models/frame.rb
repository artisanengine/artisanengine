class Frame < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of   :name, :domain
  validates_uniqueness_of :domain
end
