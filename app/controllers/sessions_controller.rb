class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create
    def create 
        user_info = request.env['omniauth.auth']

        # If user already in db, update tokens, otherwise create new user
        @user = User.find_by(twitter_id: user_info.uid)
        if @user.nil?
            @user = User.create!(
                twitter_id: user_info.uid,
                nickname: user_info.nickname,
                name: user_info.info.name,
                token: user_info.credentials.token,
                refresh_token: user_info.credentials.refresh_token,
                expires_at: Time.at(user_info.credentials.expires_at).to_datetime
            )
        else
            @user.update(
                token: user_info.credentials.token,
                refresh_token: user_info.credentials.refresh_token,
                expires_at: Time.at(user_info.credentials.expires_at).to_datetime
            )
        end
        #Cookie user and session
        session[:user_id] = @user.id 
        # render json: user_info
        redirect_to '/bookmarks'
    end
end
