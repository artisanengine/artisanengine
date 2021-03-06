# AddressAttachers are a join model that associates addresses with
# any other type of model.
class AddressAttacher < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to            :address
  belongs_to            :addressable, polymorphic: true
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :address, :addressable
  validates_associated  :address
end
