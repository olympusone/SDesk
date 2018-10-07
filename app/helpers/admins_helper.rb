module AdminsHelper
  def setup_admin admin
    admin.user || admin.build_user
    admin
  end
end
