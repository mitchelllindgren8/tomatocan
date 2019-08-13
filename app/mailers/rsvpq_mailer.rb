class RsvpqMailer < ApplicationMailer

  before_action do
    @rsvpq = params[:rsvpq]
    @user  = params[:user]
    @event = params[:event]
    @host = User.find(@event.usrid)
  end

  before_action :set_url, only: [:rsvpq_created]

  default to: -> { @user.email }

  def rsvpq_created
    inline_images
    mail subject: "Successfully created an RSVP."
  end

  private

  def set_url
    @url = event_url(host: :host, id: @user.id)
  end

  def inline_images
    img_path ="app/assets/images/social-share-button"
    img_list = ['email.png','facebook.png','linkedin.png','twitter.png']
    img_list.each {|x| attachments.inline[x] = File.read("#{img_path}/#{x}")}
    attachments.inline['starIcon.png'] = File.read("app/assets/images/starIcon.png")
  end

end
