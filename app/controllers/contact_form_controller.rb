class ContactFormController < ApplicationController
  def create
    @name = params[:contact_form][:name]
    @last_name = params[:contact_form][:last_name]
    @email = params[:contact_form][:email]
    @message = params[:contact_form][:message]

    # Perform any necessary actions with the form data
    NotifierMailer.simple_message(@name, @last_name, @email, @message).deliver_now

    flash[:success] = "Your message has been sent successfully."
    redirect_to :contact_form
  end
end
