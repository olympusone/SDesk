module RequestersHelper
  def setup_requester requester
    requester.user || requester.build_user
    requester
  end
end
