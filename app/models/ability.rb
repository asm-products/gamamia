class Ability
  include CanCan::Ability

  def initialize(user)
    # guest abilities
    can :read, Game
    can :read, Comment

    if user
      # abilities for every logged in user
      can :create, Comment
      can [:create, :upvote, :unupvote], Game

      can :manage, :all if user.role == "admin"
    end
  end
end
