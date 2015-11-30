class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: [:steam]

  def steam
    @user = User.connect_to_steam request.env["omniauth.auth"].to_hash

    sign_in @user
    current_user.remember_me!
    redirect_to root_path
  end
end