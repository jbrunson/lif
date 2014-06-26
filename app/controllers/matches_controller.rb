class MatchesController < ApplicationController
  before_filter :current_match
  before_filter :matched_user
  
  def index 
    @matches = current_user.matches
  end

  def show
    @message = Message.new
  end

  def current_match
    @match ||= Match.find(params[:id]) if params[:id]
  end

  def matched_user
    @matched_user = current_match.matched_user
  end

end
