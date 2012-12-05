ActionMailer::Base.smtp_settings = {
  :address        => 'smtp-server.tampabay.rr.com',
}

ActionMailer::Base.delivery_method = :smtp

