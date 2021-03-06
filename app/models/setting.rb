# A setting is a basic Key/Value pair assigned to a frame which can
# be used in source code to set configuration variables.
class Setting < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :name, :value, :frame
  
  # ------------------------------------------------------------------
  # Methods
  
  # Basic method for getting a setting if it exists or setting a default.
  # If an Environment variable is set with an all-caps equivalent, it 
  # will be treated as an override. So, even if a 'Awesome Factor' Setting
  # exists, ENV[ "AWESOME_FACTOR" ] will be used if it exists.
  def self.get_or_set( frame, setting_name, default = nil )
    environment_override = ENV[ setting_name.gsub( ' ', '_' ).upcase ]
    return environment_override if environment_override
    
    setting = self.find_by_frame_id_and_name( frame.id, setting_name )
    setting ? setting.value : default
  end
end
