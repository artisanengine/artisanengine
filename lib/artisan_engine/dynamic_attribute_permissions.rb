module ArtisanEngine
  module DynamicAttributePermissions
    extend ActiveSupport::Concern
  
    included do
      # Lock down all attributes by default.
      attr_accessible
    
      # Add the accessible accessor to dynamically re-add attributes as needed.
      # Or, call them with attr_accessible if everybody can set them.
      attr_accessor :accessible
    end
  
    private
  
    # Override the authorizer to accept dynamic assignment of attributes to the whitelist.
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
end