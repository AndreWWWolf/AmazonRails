class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  # To generate this controller, use the command:
  # `rails g controller Admin::Dashboard --no-helper`
  # Because we prefixed the name of the controller with `Admin::`, rails
  # created a subdirectory `admin` where it placed our controller
  # under the name `dashboard_controller.rb`.
  def index
    @users = User.order(created_at: :desc)
    @products = Product.order(created_at: :desc)
    @reviews = Review.order(created_at: :desc)
  end
  private

  def authorize_admin!
    redirect_to root_path, alert: 'Access denied!' unless current_user.admin?
  end
end
