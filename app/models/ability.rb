class Ability
  include CanCan::Ability

  def initialize(user)
    # abilities for everybody

    can :read, Comment

    unless user # abilities only for guests
      can :read, Game, Game.scheduled do |game|
        game.scheduled_at?
      end
    end

    if user
      # abilities for every logged in user
      can :create, Comment

      can :read, Game

      #cannot :manage, Game,
      can [:create, :upvote, :unupvote], Game

      can :manage, :all if user.role == "admin"
    end
  end
end
