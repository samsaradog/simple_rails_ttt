ActionMailer::Base.smtp_settings = {
  :address              => 'smtp-server.tampabay.rr.com',
  :port                 => '587'
  :enable_starttls_auto => true
}

ActionMailer::Base.delivery_method = :smtp

