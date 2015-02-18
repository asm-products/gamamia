class Ability
  include CanCan::Ability

  def initialize(user)
    # guest abilities
    can [:read], Game
    if user
      # abilities for every logged in user
      can [:read, :create], Comment
      can [:create, :upvote, :unupvote], Game

      can :manage, :all if user.role == "admin"
    end
  end
end
