class ContactMailer < ApplicationMailer

  def send_mail(contact)
    @contact = contact
    mail(
      from: @contact.email,
      to: Rails.application.credentials.admin&.fetch(:email),
      subject: '【お問い合わせ】' + @contact.subject
    )
  end
end
