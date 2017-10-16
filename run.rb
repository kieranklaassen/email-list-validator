
require 'pry'
require 'httparty'

open('emails.csv') do |emails|
  emails.read.each_line do |email_line|
    email = email_line.chomp.split(';').first
    response = HTTParty.get("https://trumail.io/json/#{email}")

    if response.parsed_response['deliverable']
      puts "#{email} is valid"
      # Deliverable
      open('valid_emails.csv', 'a') do |f|
        f.puts email_line
      end
    else
      puts "--- #{email} is invalid"
    end
  end
end
