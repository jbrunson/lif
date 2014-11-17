class MatchesController < ApplicationController
  before_filter :current_match
  before_filter :matched_user, only: [:show]

  def index 
    @matches = current_user.matches
  end

  def show
    @message = Message.new
    @history = Message.for_match(current_match)
    @photos = instagram_photos_for(current_match.matched_user).take(5) if current_match.matched_user.identities.any? { |identity| identity.provider == "instagram"  }
  end

  def current_match
    @match ||= Match.find(params[:id]) if params[:id]
  end

  def matched_user
    @matched_user = current_match.matched_user
  end
end
