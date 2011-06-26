class Ability
  include CanCan::Ability
  
  def initialize( user, frame )
    user ||= User.new
    
    case user.role
    when "Engineer"
      can :manage, :all
    when "Artisan"
      can :read,   Page, frame_id: user.frame.id
      can :create, Page, frame_id: user.frame.id
    else
      can :read,   Page, frame_id: frame.id
    end
  end
end