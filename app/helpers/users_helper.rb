module UsersHelper
  def setup_user user
    user.identities || user.identities.build
    user
  end
end
