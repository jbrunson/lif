class MessagesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @messages = current_user.received_messages
  end
  
  def create
    message = Message.new(message_params)
    message.sender_id = current_user.id
    if message.save
      flash[:notice] = "you created a message"
      
      # Send a Pusher notification
      # Pusher['private-'+params[:message][:recipient_id]].trigger('new_message', {:from => current_user.name, :body => message.body})
      Pusher['private'].trigger('new_message', {:from => current_user.name, :message_body => message.body})

      # Pusher['private-'+params[:message][:recipient_id]].trigger('new_message', {:from => current_user.name, :subject => message.subject})
      
    else
      @user = User.find(params[:message][:recipient_id])
      render :action => 'users/show'
    end
  end

  def message_params
    params.require(:message).permit(:recipient_id, :body)
  end

end
