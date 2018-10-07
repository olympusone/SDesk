module AgentsHelper
  def setup_agent agent
    agent.user || agent.build_user
    agent
  end
end
