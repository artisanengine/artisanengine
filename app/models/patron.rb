class Patron < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :address_attachers, as:      :addressable,       dependent: :destroy
  has_many   :addresses,         through: :address_attachers
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :email, :frame
  validates_format_of   :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
end
