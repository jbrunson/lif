  module UserHelpers 



  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  def current_match
    @current_match ||= Match.find(params[:match_id])
  end

  def friendly_date_format(date)
    date.strftime("%b %d, %Y")
  end

  def message_time_format(date)
    date.strftime("%-I:%M %p")
  end

  def match_exists?(user, user2)
    match = user.matches.where(matched_user: user2)

    if match.count > 0
      match.first
    else 
      nil
    end
  end

  def instagram_photos
    # current_user.identities.where(provider: "instagram").first.refresh_token_if_expired
    token = current_user.identities.where(provider: "instagram").first.token
    client = Instagram.client(:access_token => token)
    user = client.user
    client.user_recent_media
  end

  def instagram_photos_for(user)
    # current_user.identities.where(provider: "instagram").first.refresh_token_if_expired
    token = user.identities.where(provider: "instagram").first.token
    client = Instagram.client(:access_token => token)
    client.user_recent_media
  end

  def nearby_users_from_ip
    result = request ? request.location : nil
    if result
      # users = User.near([result.latitude, result.longitude], 50)
      lat = 49.2500
      lon = -123.1000
      users = User.near([lat, lon], 50)
    else
      #vancouver
      lat = 49.2500
      lon = -123.1000
      users = User.near([lat, lon], 50)
    end

    users
  end

  def nearby_users_from_location(location)
    User.near([location.latitude, location.longitude], 50)
  end

  # def nearby_users_from_ip
  #   result = request.location
  #   if result
  #     activities = Activity.near([result.latitude, result.longitude], 50)
  #   else
  #     #vancouver
  #     lat = 49.2500
  #     lon = 123.1000
  #     activities = Activity.near([lat, lon], 50).includes(:user).on_now
  #   end

  #   users = activities.map(&:user)
  # end

  def mutual_likes?(user1, user2)
    Like.where( user_id: user1.id, liked_user: user2.id ).size > 0
  end

end
