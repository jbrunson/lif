class UsersController < ApplicationController
  before_action :set_user, :finish_signup

  def show
    @user = User.find(params[:id])
    @activities = @user.activities.current_and_future.limit(5)
    @matches = @user.matches.order(created_at: :desc).limit(4)
    @photos = instagram_photos if @user.identities.any? { |identity| identity.provider == "instagram"  }
    @instagram_info = instagram_user_info_for(@user) if @user.identities.any? { |identity| identity.provider == "instagram"  }
    @nearby_users = nearby_users_from_ip.limit(40)
    @gabe = [User.find(99)]
    @jeff = [User.find(98)]
    @nearby_users = @gabe.concat(@nearby_users) unless current_user.id == 99
    @nearby_users = @jeff.concat(@nearby_users) unless current_user.id == 98
  end

  def finish_signup
    if request.patch? && params[:user] #&& params[:user][:email]
      if current_user.update(user_params)
        current_user.skip_reconfirmation!
        sign_in(current_user, :bypass => true)
        redirect_to current_user, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      accessible = [ :name, :email ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end
end