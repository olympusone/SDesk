class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role? :admin
      can :manage, :all
    elsif user.role? :agent
      can :manage, :all
      cannot :manage, Admin
    elsif user.role? :requester
      can :manage, :all
    else
      can :create, Ticket
      can :read, [SolutionCategory, SolutionFolder, Solution]
    end
  end
end