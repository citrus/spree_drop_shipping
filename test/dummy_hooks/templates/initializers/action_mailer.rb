# config/initializers/action_mailer.rb

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.sendmail_settings = {
  :arguments => '-r no-reply@example.com'
}
