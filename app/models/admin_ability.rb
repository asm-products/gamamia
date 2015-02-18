class AdminAbility
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role == "admin"
      can :manage, :all
    else
      cannot :manage, :all
    end
  end
end
