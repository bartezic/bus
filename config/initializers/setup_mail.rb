ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "91.234.32.79",
  :user_name            => "bartezic",
  :password             => "1816151620",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"

class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "bartezic@gmail.com"
  end
end

Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?