class LikesController < ApplicationController

  def create
    @like = Like.new(user_id: current_user.id, user2_id: params[:id])
  end


   def create
    @like = current_user.likes.build(params[:id])

    if @like.save
      render :nothing => true, :status => :ok
    else
      #do something
    end
  end

end
