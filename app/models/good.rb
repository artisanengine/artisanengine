class Good < ActiveRecord::Base
  attr_accessible :name, :description
  
  # ------------------------------------------------------------------
  # Callbacks
  
  after_create :create_default_option
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :options
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :name, :frame
  
  # ------------------------------------------------------------------
  private
  
  def create_default_option
    options.create! name: 'Type', default: 'Default'
  end
end
