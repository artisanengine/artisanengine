# Each frame has a blog. It basically functions as a wrapper for posts.
class Blog < ActiveRecord::Base
  attr_accessible :name
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :posts, dependent: :destroy
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :name, :frame
end