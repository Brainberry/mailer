#!/usr/bin/env ruby

require File.expand_path('../lib/boot', __FILE__)

Bundler.require(:default, :production) if defined?(Bundler)

html_path = File.join(File.dirname(__FILE__), 'tmp', 'mail.html')
email_path = File.join(File.dirname(__FILE__), 'tmp', 'emails.txt')

mail = Mail.new do
  from 'no-reply@brainberry.com.ua'
  #to 'you@test.lindsaar.net'
  subject "LG Life's Good"
  content_type 'text/html; charset=UTF-8'
  
  body File.read(html_path)
end

mail.delivery_method :sendmail

IO.readlines(email_path).each do |email|
  mail[:to] = email.strip
  mail.deliver!
end
