class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  attr_accessor   :accessible
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  
  # ------------------------------------------------------------------
  # Devise
  
  devise :database_authenticatable, authentication_keys: [ :email, :frame_id ]
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of   :first_name, :last_name, :email, :frame
  validates_uniqueness_of :email, :scope => :frame_id
  validates_format_of     :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  # ------------------------------------------------------------------
  # Roles
  
  ROLES = %w( Artisan Patron )
  
  def is_an_engineer?
    role == 'Engineer'
  end
  
  private
    def mass_assignment_authorizer( role = :default )
      if accessible == :all
        # Normally, this would return all the attributes blacklisted by
        # attr_protected. But since we have defined any, it is just a convenient
        # way to return all the model's attributes.
        self.class.protected_attributes   
      else
        # If an array of symbols is passed to accessible, it will add those attributes
        # to the whitelist.
        super + ( accessible || [] )
      end
    end
end