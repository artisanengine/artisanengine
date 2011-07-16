class Address < ActiveRecord::Base
  belongs_to :frame
  has_many :address_attachers, dependent: :destroy
  validates_presence_of :first_name, :last_name, :address_1, :city, :country, :postal_code, :frame
end
