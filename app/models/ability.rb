# Authorization model which determines role-based permissions.
class Ability
  include CanCan::Ability
  
  def initialize( user, current_frame )
    user ||= User.new
    
    case user.role
    
    when "Engineer"
      can :manage, :all
    
    when "Artisan"
      can :manage, [ Page, Image ], frame_id: user.frame.id
    
    else
      can :read,   [ Page, Image ], frame_id: current_frame.id
    
    end
  end
end