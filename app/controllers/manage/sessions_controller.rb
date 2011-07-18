module Manage
  class SessionsController < Devise::SessionsController
    layout 'authenticate'
    
    def after_sign_in_path_for( resource_or_scope )
      manage_path
    end
  end
end