# Addresses represent real-world addresses and should be associated with
# an order or a patron.
class Address < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :address_attachers, dependent: :destroy
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :first_name, :last_name, :address_1, :city, 
                        :country, :postal_code, :frame
end
