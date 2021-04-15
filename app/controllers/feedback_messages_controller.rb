class FeedbackMessagesController < ApplicationController
  before_action :set_feedback_message, only: [:destroy]

  def index
    @feedback_messages = nil

    if user_signed_in?
      if current_user.email == 'svetoz@gmail.com'
        @feedback_messages = FeedbackMessage.all.order(id: :desc)
      else
        @feedback_messages = current_user.feedback_messages.order(id: :desc)
      end
    end

    if @feedback_messages
      render json: FeedbackMessageSerializer.new(@feedback_messages).serialized_json
    else
      render json: "Can't find messages", status: :not_found
    end
  end

  def new
    contacts = user_signed_in? ? current_user.email : ''
    render json: {
      message: "",
      contacts: contacts
    }.as_json
  end

  def create
    @feedback_message = FeedbackMessage.new(feedback_message_params)
    @feedback_message.user = current_user if user_signed_in?

    if @feedback_message.save
      ### Pushover (for Pullover)
      if true # Rails.env.production?
        message = "#{@feedback_message.message}\n#{@feedback_message.contacts}"
        Pushover::Message.new(
          token: Rails.application.credentials.dig(:common, :pushover, :token), 
          user: Rails.application.credentials.dig(:common, :pushover, :user),
          title: 'VizMarket: feedback',
          message: message,
          priority: 0
        ).push
      end

      render json: FeedbackMessageSerializer.new(@feedback_message).serialized_json, status: :created
    else
      puts "@product.errors = #{@feedback_message.errors.as_json}"
      render json: @feedback_message.errors.as_json, status: :unprocessable_entity
    end
  end

  def destroy
    if @feedback_message.destroy
      render json: {id: @feedback_message.id, title: @feedback_message.message}, status: :ok
    else
      render json: @feedback_message.errors.as_json, status: :unprocessable_entity
    end
  end

  private

  def feedback_message_params
    params.require(:feedback).permit(:message, :contacts)
  end

  def set_feedback_message
    @feedback_message = FeedbackMessage.find_by(id: params[:id])

    if !@feedback_message || @feedback_message.user != current_user
      render json: "Can't find message with id: #{params[:id]}", status: :not_found
      return
    end
  end
end
