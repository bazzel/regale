class CreateAdminService
  def call
    User.find_or_create_by!(email: ENV.fetch('ADMIN_EMAIL')) do |user|
      user.admin!
    end
  end
end
