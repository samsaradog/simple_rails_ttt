ActionMailer::Base.smtp_settings = {
  # address: "smtp-server.tampabay.rr.com",
  # address: "smtp.gmail.com",
  # user_name: "warnerwt",
  :address              => 'smtp.sendgrid.net',
  :port                 => '587',
  :user_name            => 'shinkyowill',
  :domain               => 'heroku.com',
  :password             => 'g4H>r9c3',
  :authentication       => :plain,
  enable_starttls_auto: true
}

ActionMailer::Base.delivery_method = :smtp

