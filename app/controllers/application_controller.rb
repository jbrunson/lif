class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_match
  helper_method :friendly_date_format
  helper_method :match_exists?
  helper_method :message_time_format
  helper_method :instagram_photos

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

  def nearby_users_from_ip
    result = request.location
    if result
      activities = Activity.near([result.latitude, result.longitude], 50)
    else
      #vancouver
      lat = 49.2500
      lon = 123.1000
      activities = Activity.near([lat, lon], 50).includes(:user).on_now
    end

    users = activities.map(&:user)
  end

end
