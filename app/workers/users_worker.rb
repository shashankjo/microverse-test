module Workers
  class UsersWorker
    include Sidekiq::Worker
    sidekiq_options(queue: :default)

    def perform
      users = Services::Api::FetchUsers.new.call
      users.each {  |user| persist(user) unless User.find_by(email: user["email"]).present? }
    end

    def persist(user)
      User.create(
        first_name: user["first_name"],
        last_name:  user["last_name"],
        status:     user["status"],
        email:      user["email"]
      )
    end
  end
end

