class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
    @user = @profile.user
    @photos = instagram_photos_for(@user) if @user.identities.any? { |identity| identity.provider == "instagram"  }
    @instagram_info = instagram_user_info_for(@user) if @user.identities.any? { |identity| identity.provider == "instagram"  }
    if @user
      @match = match_exists?(current_user, @user)
      render action: :show
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    profile = Profile.find(params[:id])
    profile.update!(profile_params)
    redirect_to profile

  end

  private

  def profile_params
    params.require(:profile).permit(:about_me)
  end


end
 

