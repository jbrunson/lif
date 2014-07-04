class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @photos = instagram_photos_for(@user) if @user.identities.any? { |identity| identity.provider == "instagram"  }
    if @user
      @match = match_exists?(current_user, @user)
      render action: :show
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end
end
 

