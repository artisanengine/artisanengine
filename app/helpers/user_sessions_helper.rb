module UserSessionsHelper
  def current_user
    @current_user ||= user_from_session
  end
  
  def current_session
    @current_session ||= UserSession.find
  end
  
  private
    def user_from_session
      current_session.try( :user )
    end
end