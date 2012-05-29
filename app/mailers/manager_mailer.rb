#encoding: utf-8

class ManagerMailer < ActionMailer::Base
  default :from => "notifications@bus-guide.com"
 
  def reserve_email(params)
    @params = params
    mail(:to => 'bartezic@inbox.ru', :subject => "Нова резервація")
  end

  def request_email(params)
    @params = params
    mail(:to => 'bartezic@inbox.ru', :subject => "Новий запит")
  end
end
