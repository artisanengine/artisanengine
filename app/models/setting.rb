class Setting < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :name, :value, :frame
  
  # ------------------------------------------------------------------
  # Methods
  
  def self.get_or_set( frame, setting_name, default = nil )
    setting = self.find_by_frame_id_and_name( frame.id, setting_name )
    
    if setting
      environment_override = ENV[ setting_name.gsub( ' ', '_' ).upcase ]
      environment_override ? environment_override : setting.value 
    else
      default
    end
  end
end
