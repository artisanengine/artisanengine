module Develop
  class SessionsController < Devise::SessionsController
    layout 'authenticate'
    
    def after_sign_in_path_for( resource_or_scope )
      develop_path
    end
    
    def after_sign_out_path_for( resource_or_scope )
      develop_path
    end
  end
end