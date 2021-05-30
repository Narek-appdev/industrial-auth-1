class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed followers following discover ]
  before_action :ensure_current_user_is_accessing_own_feed_or_discover, only: %i[ feed discover ]

  private


    def set_user
      if params[:username]
        @user = User.find_by!(username: params.fetch(:username))
      else
        @user = current_user
      end
    end

    def ensure_current_user_is_accessing_own_feed_or_discover
      if current_user != @user
        redirect_back fallback_location: root_url, alert: "You are not authorized"
      end
    end


end