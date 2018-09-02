class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role? :agent
      can :manage, :all
    elsif user.role? :requester
      can :manage, :all
    else
      can :create, Ticket
    end
  end
end