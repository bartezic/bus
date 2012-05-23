#encoding: utf-8

class UserMailer < ActionMailer::Base
  default :from => "notifications@bus-guide.com"
 
  def reserve_email(username, email)
    @username = username
    mail(:to => email, :subject => "Дякуємо за резервацію")
  end
end
