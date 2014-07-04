class LikesController < ApplicationController

  def new
    @like = Like.new
  end


  def create
    liked_user = User.find(params[:user_id])
    @like = current_user.likes.build(liked_user: liked_user)

    if @like.save
      #check for match
      if mutual_likes?(liked_user, current_user)
        conversation = Conversation.new.save

        match = current_user.matches.build(matched_user: liked_user, conversation: conversation)
        match.save
        other_match = liked_user.matches.build(matched_user: current_user, conversation: conversation)
        other_match.save
      end
      render :nothing => true, :status => :ok
    else
      #do something
    end
  end
end
