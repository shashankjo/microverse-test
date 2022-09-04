module UserHelper
  def users_record_exists?(users)
    users.count > 1
  end
end
