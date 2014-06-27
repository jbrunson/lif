class LikesController < ApplicationController

  def new
    @like = Like.new
  end


   def create
    liked_user = User.find(params[:user_id])
    @like = current_user.likes.build(liked_user: liked_user)

    if @like.save
      #check for match
      if Like.where( user_id: @like.liked_user, liked_user: current_user.id ).size > 0
        match = current_user.matches.build(matched_user: liked_user)
        match.save
        other_match = liked_user.matches.build(matched_user: current_user)
        other_match.save
      end
      render :nothing => true, :status => :ok
    else
      #do something
    end
  end

end
