class Patron < ActiveRecord::Base
  has_many :address_attachers, as:      :addressable,       dependent: :destroy
  has_many :addresses,         through: :address_attachers
  
  validates_presence_of :email
  validates_format_of   :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
end
