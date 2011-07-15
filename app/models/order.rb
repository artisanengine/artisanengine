class Order < ActiveRecord::Base
  belongs_to :frame
  has_many   :line_items
  
  validates_presence_of :frame
  
  state_machine :status, :initial => :new
end
