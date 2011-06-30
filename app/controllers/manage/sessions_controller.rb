module Manage
  class SessionsController < Devise::SessionsController
    layout 'manage'
  end
end