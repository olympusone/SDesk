class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role? :admin
      can :manage, :all
    elsif user.role? :agent
      can :update, Agent, id: user.user_id
      can :manage, [Ticket, TicketTemplate]
      can :manage, Requester
      can :manage, [SolutionCategory, SolutionFolder, Solution]
    elsif user.role? :requester
      can :update, Requester, id: user.user_id
      can :create, Ticket
      can [:read, :update], Ticket, requester_id: user.user_id
      can :read, [SolutionCategory, SolutionFolder, Solution]
      can :knowledge_base, Solution
    else
      can :create, Ticket
      can [:knowledge_base, :show], Solution
      can :read, [SolutionCategory, SolutionFolder, Solution]
    end
  end
end