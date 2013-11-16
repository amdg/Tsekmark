class MessagesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_mailbox, :get_box, :get_actor
  def index
    redirect_to conversations_path(:box => @box)
  end

  def show
    if @message = Message.find_by_id(params[:id]) and @conversation = @message.conversation
      if @conversation.is_participant?(@actor)
        redirect_to conversation_path(@conversation, :box => @box, :anchor => "message_" + @message.id.to_s)
        return
      end
    end
    redirect_to conversations_path(:box => @box)
  end

  def new
    if params[:receiver].present?
      #@recipient = Actor.find_by_slug(params[:receiver])
      return if @recipient.nil?
      @recipient = nil if @recipient == blaster
    end
  end

  def create
    message_params = params[:message]
    klass = message_params[:recipient_type].capitalize.constantize
    another_blaster = klass.find message_params[:recipient_id]

    @receipt = blaster.send_message(another_blaster, message_params[:body], message_params[:subject])
    if (@receipt.errors.blank?)
      @conversation = @receipt.conversation
      flash[:success]= 'Message sent!'
    end
    redirect_to conversation_path(@conversation, :box => :sentbox)
  end

  def update

  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy

  end

  private

  def get_mailbox
    @mailbox = blaster.mailbox
  end

  def get_actor
    @actor = blaster
  end

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
      @box = "inbox"
      return
    end
    @box = params[:box]
  end

end