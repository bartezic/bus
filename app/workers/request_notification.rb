class RequestNotification
  @queue = :request_notification_queue

  def self.perform(request_id)
    request = Request.find(request_id)
    UserMailer.request_email(request.name,request.email).deliver
    ManagerMailer.request_email(request).deliver
  end
end