class ApplicationController < ActionController::API
  include Pundit::Authorization

  after_action :verify_authorized

  rescue_from Pundit::NotAuthorizedError, with: :forbidden
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def pundit_user
    @current_user
  end

  private

  def forbidden
    render json: { error: "You are not authorized to perform this action" }, status: :forbidden
  end

  def not_found
    render json: { error: "Not found" }, status: :not_found
  end
end
