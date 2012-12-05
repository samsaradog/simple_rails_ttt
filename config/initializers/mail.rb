ActionMailer::Base.smtp_settings = {
  :address              => 'smtp.sendgrid.net',
  :port                 => '587',
  :user_name            => 'shinkyowill',
  :domain               => 'heroku.com',
  :password             => 'asdfgh',
  :authentication       => :plain,
  enable_starttls_auto: true
}

ActionMailer::Base.delivery_method = :smtp

