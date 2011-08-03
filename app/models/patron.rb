# A patron is a user that has performed some meaningful interaction with
# the artisan, such as purchasing an item or signing up for the mailing
# list.
class Patron < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :address_attachers, as:      :addressable,       dependent: :destroy
  has_many   :addresses,         through: :address_attachers
  has_many   :orders
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :email, :frame
  validates_format_of   :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # ------------------------------------------------------------------
  # Scopes
  
  scope :subscribed, lambda { where( subscribed: true ) }
end
