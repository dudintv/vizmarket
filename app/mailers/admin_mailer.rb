class AdminMailer < ApplicationMailer
  def feedback_email
    @message = params[:message]
    @contacts = params[:contacts]
    mail(to: 'svetoz@gmail.com', subject: 'Feedback from VizMarket')
  end
end
