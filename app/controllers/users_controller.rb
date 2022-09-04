require_relative '../workers/users_worker'

class UsersController < ApplicationController
  def index
    status = params[:status]
    if status.present?
      @users = User.where(status: status).order(:id).page params[:page]
    else
      @users = User.order(:id).page params[:page]
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def fetch_data
    populate_data
    redirect_to :action => 'index'
  end

  def delete_data
    User.destroy_all
    redirect_to :action => 'index'
  end

  private

  def populate_data
    #Workers::UsersWorker.perform_async()
    users = Api::FetchUsers.new.call
    users.each {  |user| persist(user) unless User.find_by(email: user["email"]).present? }
  end

  def persist(user)
    User.create(
      user_id:    user["id"].to_s,
      first_name: user["first_name"],
      last_name:  user["last_name"],
      status:     user["status"],
      email:      user["email"]
      )
  end
end
