class Api::SessionsController < Api::ApplicationController
  skip_before_action :doorkeeper_authorize!, only: :create

  def create
    user = User.authenticate users_params
    if user
      render json: {data: Api::GenerateTokenService.new(user).call}, status: 200
    else
      render json: {errors: I18n.t("errors.api.sessions_controller.login.failed")}, status: 400
    end
  end

  def destroy
    revoke_token_service = Api::RevokeTokenService.new doorkeeper_token.token
    revoke_token_service.execute
    if revoke_token_service.success?
      render json: {}, status: 200
    else
      render json: {errors: revoke_token_service.errors}, status: 400
    end
  end

  private
  def users_params
   params.fetch(:user,{}).permit(:name, :password)
  end
end