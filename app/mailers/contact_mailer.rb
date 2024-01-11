class ContactMailer < ApplicationMailer

  def send_mail(contact)
    @contact = contact
    mail(
      from: @contact.email,
      to: ENV['MAIL_ADDRESS'],
      subject: '【お問い合わせ】' + @contact.subject
    )
  end
end
