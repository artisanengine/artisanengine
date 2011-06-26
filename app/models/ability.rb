class Ability
  include CanCan::Ability
  
  def initialize( user, current_frame )
    user ||= User.new
    
    case user.role
    when "Engineer"
      can :manage, :all
    when "Artisan"
      can [ :read, :create ], Page, frame_id: user.frame.id
    else
      can :read, Page, frame_id: current_frame.id
    end
  end
end